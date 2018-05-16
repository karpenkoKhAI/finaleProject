#!groovy
pipeline {
    agent any
    stages {
        stage('Build image') {
            
                checkout scm
          
                echo 'Build Image'
                def customImage = docker.build("my-image:${env.BUILD_ID}")
            
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
