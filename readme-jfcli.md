# Spring PetClinic Sample Application using JFrog CLI

## Prerequisites
- Read and understand the PetClinic application original documentation: [ReadME.MD](readme-original.md)
- Read and understand the PetClinic application jenkins pipeline documentation: [ReadME.MD](readme.md)

## Objective
Develop a DevOps pipeline to automate tasks such as code compile, unit testing, creation of container, and upload of artifacts to a repository. This will streamline the software development process using JFrog CLI.

Note: This process with not deploy to the envionrmnet platform. 

## Jenkins
### JAR
#### Package DevOps steps
- [pipeline file: Jenkinsfile.mvn.jfrog-cli](./Jenkinsfile.mvn.jfrog-cli)
- [![Walk through demo](https://img.youtube.com/vi/cHC79tWz8d4/0.jpg)](https://www.youtube.com/watch?v=cHC79tWz8d4)
#### SBOM
- [pipeline file: Jenkinsfile.mvn.jfrog-cli](./Jenkinsfile.mvn.buildInfo.jfrog-cli)
- [![Walk through demo](https://img.youtube.com/vi/Sm4vWhPsvAY/0.jpg)](https://www.youtube.com/watch?v=Sm4vWhPsvAY)
#### Release Bundle v2 - Create
- [pipeline file: Jenkinsfile.mvn.jfrog-cli](./Jenkinsfile.mvn.jfrog-cli)
- [![Walk through demo](https://img.youtube.com/vi/zap2gfYA3Vs/0.jpg)](https://www.youtube.com/watch?v=zap2gfYA3Vs)
#### Release Bundle v2 - Promote
- [pipeline file: Jenkinsfile.mvn.jfrog-cli](./Jenkinsfile.mvn.jfrog-cli)
- [![Walk through demo](https://img.youtube.com/vi/xXSdGRBPFjg/0.jpg)](https://www.youtube.com/watch?v=xXSdGRBPFjg)


## LAST UMCOMMIT
`````
git reset --hard HEAD~1
git push origin -f
`````

## License
The Spring PetClinic sample application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
