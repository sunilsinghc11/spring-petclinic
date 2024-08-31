# SET meta-data to differentiate application category, such as application or internal-library
# export PACKAGE_CATEGORIES=(WEBAPP, SERVICE, LIBRARY, BASEIMAGE)
clear
# TOKEN SETUP
# jf c add --user=krishnam --interactive=true --url=https://psazuse.jfrog.io --overwrite=true 

# Config - Artifactory info
export JF_RT_URL="https://psazuse.jfrog.io" JFROG_NAME="psazuse" JFROG_RT_USER="krishnam" JFROG_CLI_LOG_LEVEL="DEBUG" # JF_BEARER_TOKEN="<GET_YOUR_OWN_KEY>"
export RT_PROJECT_REPO="krishnam-mvn"

echo " JFROG_NAME: $JFROG_NAME \n JF_RT_URL: $JF_RT_URL \n JFROG_RT_USER: $JFROG_RT_USER \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL \n "

# MVN 
## Config - project
### CLI
export BUILD_NAME="spring-petclinic-rbv2" BUILD_ID="cmd.$(date '+%Y-%m-%d-%H-%M')" PACKAGE_CATEGORY="WEBAPP" RT_PROJECT_RB_SIGNING_KEY="krishnam"

### Jenkins
# export BUILD_NAME=${env.JOB_NAME} BUILD_ID=${env.BUILD_ID} PACKAGE_CATEGORY="WEBAPP"
# References: 
# https://www.jenkins.io/doc/book/pipeline/jenkinsfile/#using-environment-variables 
# https://wiki.jenkins.io/JENKINS/Building+a+software+project 

echo " BUILD_NAME: $BUILD_NAME \n BUILD_ID: $BUILD_ID \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL  \n RT_PROJECT_REPO: $RT_PROJECT_REPO  \n "

jf mvnc --server-id-resolve ${JFROG_NAME} --server-id-deploy ${JFROG_NAME} --repo-resolve-releases ${RT_PROJECT_REPO}-virtual --repo-resolve-snapshots ${RT_PROJECT_REPO}-virtual --repo-deploy-releases ${RT_PROJECT_REPO}-local --repo-deploy-snapshots ${RT_PROJECT_REPO}-dev-local

## Audit
# jf audit --mvn --extended-table=true

## Create Build
echo "\n\n**** MVN: Package ****\n\n" # --scan=true
jf mvn clean install -DskipTests=true --build-name=${BUILD_NAME} --build-number=${BUILD_ID} --detailed-summary=true 

## bce:build-collect-env - Collect environment variables. Environment variables can be excluded using the build-publish command.
jf rt bce ${BUILD_NAME} ${BUILD_ID}

## bag:build-add-git - Collect VCS details from git and add them to a build.
jf rt bag ${BUILD_NAME} ${BUILD_ID}

## bp:build-publish - Publish build info
echo "\n\n**** Build Info: Publish ****\n\n"
jf rt bp ${BUILD_NAME} ${BUILD_ID} --detailed-summary=true

## RBv2: release bundle - create
# ref: https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/cli-for-jfrog-artifactory/release-lifecycle-management
echo "\n\n**** RBv2: Create ****\n\n"
echo " BUILD_NAME: $BUILD_NAME \n BUILD_ID: $BUILD_ID \n RT_PROJECT_REPO: $RT_PROJECT_REPO  \n RT_PROJECT_RB_SIGNING_KEY: $RT_PROJECT_RB_SIGNING_KEY  \n "

echo "{ \"files\": [ {\"build\": \"${BUILD_NAME}/${BUILD_ID}\", \"includeDeps\": \"false\" } ] }"  > rbv2-spec-${BUILD_ID}.json

echo "\n" && cat rbv2-spec-${BUILD_ID}.json && echo "\n"

# --server-id="psazuse" --access-token="${JF_ACCESS_TOKEN}" 
jf rbc ${BUILD_NAME} ${BUILD_ID} --sync="true" --access-token="${JF_ACCESS_TOKEN=}" --url="${JF_RT_URL}" --signing-key="${RT_PROJECT_RB_SIGNING_KEY}" --spec="rbv2-spec-${BUILD_ID}.json" --spec-vars="build_name=${BUILD_NAME};build_id=${BUILD_ID};PACKAGE_CATEGORY=${PACKAGE_CATEGORY};" --server-id="psazuse" --sync=true


## RBv2: release bundle - DEV promote
# jf rbp --sync=true --url="${JF_RT_URL}" --access-token="${JF_BEARER_TOKEN}" --signing-key="${RT_PROJECT_RB_SIGNING_KEY}" ${BUILD_NAME} ${BUILD_ID} DEV

## RBv2: release bundle - QA promote
# jf rbp --sync=true --url="${JF_RT_URL}" --access-token="${JF_BEARER_TOKEN}" --signing-key="${RT_PROJECT_RB_SIGNING_KEY}" ${BUILD_NAME} ${BUILD_ID} QA



echo "\n\n**** DONE ****\n\n"