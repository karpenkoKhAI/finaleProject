#!groovy
node('JenkinsSlave-01'){ 
  
    
    
  
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
       sh "docker build -t nginximage ."
    }

  /*  stage('Docker Push') {
          withCredentials([usernamePassword(credentialsId: 'Dockerhub', passwordVariable: 'DockerhubPassword', usernameVariable: 'DockerhubUser')]) 
      {
          sh "docker tag nginximage karpenkokhai/finaleproject"
          sh "docker login -u ${env.DockerhubUser} -p ${env.DockerhubPassword}"
          sh "docker push karpenkokhai/finaleproject:latest"
      }
    }*/
      stage('Run nginx server'){
          sh "docker-machine env aws-sa" 
          sh 'eval $(docker-machine env aws-sa)'
          sh "docker run -p 80:80 nginximage"    
      }
}




                
            
