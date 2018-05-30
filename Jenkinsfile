#!groovy
node('JenkinsSlave-01'){ 
 stage('Clone repository') {
        checkout scm
    }
 
 stage('Build image') {
       sh "docker build -t nginximage ."
    }
 
 stage('Docker Push') {
          sh 'docker login -u $dockerHubUser -p $dockerHubPassword'
          sh "docker tag nginximage karpenkokhai/finaleproject"
          sh "docker push karpenkokhai/finaleproject"
     }

 stage('Run nginx server'){
          sh 'eval $(docker-machine env aws03)'
          sh "docker-machine env aws03" 
          sh "docker run -p 80:80 nginximage"    
      }
  
}




                
            
