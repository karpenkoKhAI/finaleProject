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
       sh "docker start nginximage"
       sh "docker stop nginximage"
    }

    stage('Push image') {
       sh "docker tag nginximage karpenkokhai/finaleproject"
       sh "docker push karpenkokhai/finaleproject"
       // sh "docker push karpenkokhai/finaleproject"
          
        }
    }


                
            
