#!groovy
pipeline {
    agent { dockerfile true }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                
                echo 'Image was build'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
