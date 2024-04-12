pipeline {
    agent any

    stages{
        stage('Build Maven'){
            steps{
                
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sunilsinghc11/spring-petclinic.git']])
               // sh 'mvn -s ./settings.xml clean deploy'
            }
        }
        stage('Test'){
            steps{
                
              // sh 'mvn -s ./settings.xml test'
              sh 'echo hi'
              
            }
        }

        stage('Build Image'){
            steps{
                script {
                        withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                             //withCredentials([string(credentialsId: 'docker-pass', variable: 'sunil-docker-pass')]) {
                            
                          sh  'docker login -u sunilsc -p ${dockerhubpwd}'
                          }  
                 sh 'docker build -t sunilsc/petclinic:1.0.0 .'
                }
               
            }
        }
         stage('Deploy Image'){
            steps{
                script {
                        withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh  'docker login -u sunilsc -p ${dockerhubpwd}'
                          }  
                 sh 'docker push sunilsc/petclinic:1.0.0'
                }
               
            }
        }
    
        
    }
}
