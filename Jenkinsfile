#!groovy
node('JenkinsSlave-01'){ 
 stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }
 stage('Build image') {
       sh "docker build -t nginximage ."
    }

/* stage('Docker Push') {
         agent any
       		 
       withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
           sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
           sh "docker tag nginximage karpenkokhai/finaleproject"
           sh "docker push karpenkokhai/finaleproject"
     }
    }*/
 stage('Run nginx server'){
          sh "docker-machine env awsMachine" 
          sh 'eval $(docker-machine env awsMachine)'
          sh "docker run -p 80:80 nginximage"    
      }
}




                
            
