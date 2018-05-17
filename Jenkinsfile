#!groovy
  node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
       sh "docker build -t nginximage ."
    }

    stage('Test image') {
       sh "docker run -p 80:80 nginximage"
       sh "docker stop nginximage"
    }

    stage('Push image') {
          docker pull karpenkokhai/finaleproject
          
        }
    }


                
            
