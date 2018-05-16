#!groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                agent { dockerfile true }
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
