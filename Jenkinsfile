#!groovy
  node('Slave') {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
       sh "docker build -t nginximage ."
    }

    stage('Test image') {
       //sh "docker start nginximage"
       //sh "docker stop nginximage"
       }
    stage('Docker Push') {
          withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) 
      {
          sh "docker tag nginximage karpenkokhai/finaleproject"
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push karpenkokhai/finaleproject:latest'
      }
      
    }
}


                
            
