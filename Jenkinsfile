#!groovy
node('JenkinsSlave-01){ 
  
    try{
    notifyStarted()
  
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
       sh "docker build -t nginximage ."
    }

    stage('Docker Push') {
          withCredentials([usernamePassword(credentialsId: 'Dockerhub', passwordVariable: 'DockerhubPassword', usernameVariable: 'DockerhubUser')]) 
      {
          sh "docker tag nginximage karpenkokhai/finaleproject"
          sh "docker login -u ${env.DockerhubUser} -p ${env.DockerhubPassword}"
          sh "docker push karpenkokhai/finaleproject:latest"
      }
      stage('Run nginx server'){
          sh "docker-machine env ReleaseServer"
          sh "eval $(docker-machine env ReleaseServer)"
          sh "docker run -p 80:80 nginximage"    
      }
    }
    
    notifySuccessful()
    
    } catch (e) {
        currentBuild.result = "FAILED"
        notifyFailed()
        throw e
    }   finally {
        // Success or failure, always send notifications
        notifyBuild(currentBuild.result)
    }
}

def notifyStarted() {
  // send to Slack
  slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
 
  // send to HipChat
  hipchatSend (color: 'YELLOW', notify: true,
      message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
    )
 
  // send to email
  emailext (
      subject: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}

def notifySuccessful() {
  slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
 
  hipchatSend (color: 'GREEN', notify: true,
      message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
    )
 
  emailext (
      subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}

def notifyFailed() {
  slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
 
  hipchatSend (color: 'RED', notify: true,
      message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
    )
 
  emailext (
      subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'
 
  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>"""
 
  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }
 
  // Send notifications
  slackSend (color: colorCode, message: summary)
 
  hipchatSend (color: color, notify: true, message: summary)
 
  emailext (
      subject: subject,
      body: details,
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}


                
            
