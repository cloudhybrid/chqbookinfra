pipeline {
    agent {
        node {
            label 'master'
        }
    }

  options{
      ansiColor('xterm')
  }

  parameters{
      choice(choices: 'us-east-1\nus-east-2\nus-west-1\nus-west-2\nap-south-1', description: 'Region in which you want to deploy code', name: 'Region')
      choice(choices: 'management\nprod', description: 'ENV in which you want to deploy code Management or Prod', name: 'Environment')
      string(defaultValue: 'jenkins_profile', description: 'Name of the instance profile that terraform will use', name: 'Iam_Profile')
  }

  stages {
      stage('Checkout the latest code of Repo') {
          steps {
              checkout scm
              echo "Listing all repo content"
              sh "ls -l"
              sh "whoami"
          }
      }

      stage('Initialize the terraform with module and plugin') {
          steps {
              echo "terraform init"
          }
      }

      stage('Plan the infra with terraform') {
          steps {
              echo "terraform plan -var region=${Region} -var profile=${Iam_Profile}"
                mail(to: 'abhishek.dubey@opstree.com',
                    subject: "${currentBuild.fullDisplayName} is ready for deployment",
                    body: "Please approve the URL: ${env.BUILD_URL}input")
                input message: 'Do you want to deploy terraform code on ${Environment}?', submitterParameter: 'Action'
          }
      }

      if(params.Environment == "management")
      {
          stage('Deploying management infra with terraform') {
              steps {
                  echo "Deployement on management is succesful !!!"
              }
          }
      }
  }
}
