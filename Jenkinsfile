#!groovy
  node('JenkinsSlave-01') {
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
          withCredentials([usernamePassword(credentialsId: 'Dockerhub', passwordVariable: 'DockerhubPassword', usernameVariable: 'DockerhubUser')]) 
      {
          sh "docker tag nginximage karpenkokhai/finaleproject"
          sh "docker login -u ${env.DockerhubUser} -p ${env.DockerhubPassword}"
          sh 'docker push karpenkokhai/finaleproject:latest'
      }
      
    }
}


                
            
