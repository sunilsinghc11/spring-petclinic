pipeline {
    agent any

    stages{
        stage('Build Maven'){
            steps{
                
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sunilsinghc11/spring-petclinic.git']])
                sh 'mvn -s ./settings.xml clean deploy'
            }
        }
        stage('Test'){
            steps{
                
               sh 'mvn -s ./settings.xml test'
              
            }
        }
        stage('Build Image'){
            steps{
               sh 'docker build -t sunilsc/petclinic:1.0.0 .'
            }
        }
         stage('Deploy Image'){
            steps{
                script {
                        withCredentials([string(credentialsId: 'docker-pass', variable: 'sunil-docker-pass')]) {
                            // some block
                          sh  'docker login -u sunilsc -p PetClinic11!'
                          }  
                 sh 'docker push sunilsc/petclinic:1.0.0'
                }
               
            }
        }
    
        
    }
}