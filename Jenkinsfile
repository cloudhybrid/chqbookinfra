ansiColor('xterm') {
    properties ([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')),
        [$class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false],
        disableConcurrentBuilds(),
        parameters([choice(choices: 'us-east-1\nus-east-2\nus-west-1\nus-west-2\nap-south-1', description: 'Region in which you want to deploy code', name: 'Region'),
        choice(choices: 'management\nprod', description: 'ENV or VPC in which you want to deploy code Management or Prod', name: 'Environment'),
        string(defaultValue: 'jenkins_profile', description: 'Name of the instance profile that terraform will use', name: 'Iam_Profile')])

    ])
    def config = [:]
    
    node {
        stage("Checkout the latest code of Repo")
        {
            checkout scm
            echo "Listing all repo content"
            sh "ls -l"
            sh "whoami"
        }

        stage("Initialize the terraform with module and plugin")
        {
            echo "Initializing the modules and plugin for terraform"
            sh "cd ${params.Environment}_infra; terraform init"
        }

        stage("Plan the infra with terraform")
        {
            echo "Planning the infra for ${params.Environment}"
            sh "cd ${params.Environment}_infra; terraform plan -var region=${Region} -var profile=${Iam_Profile}"

            mail(to: 'abhishek.dubey@opstree.com',
                subject: "${currentBuild.fullDisplayName} is ready for deployment",
                body: "Please approve the URL for ${params.Environment}: ${env.BUILD_URL}input")

            input message: 'Do you want to deploy terraform code?', submitterParameter: 'Action'
        }

        if(params.Environment == "management")
        {
            stage("Deploying on Management VPC with terraform"){
                echo "Deploying on management vpc with terraform"
                sh "cd ${params.Environment}_infra; terraform apply -auto-approve -var region=${Region} -var profile=${Iam_Profile}"
            }     
        }

        if(params.Environment == "prod")
        {
            stage("Deploying on Prod VPC with terraform"){
                echo "Deploying on Prod vpc with terraform"
                sh "cd ${params.Environment}_infra; terraform apply -auto-approve -var region=${Region} -var profile=${Iam_Profile}"
            }
        }
    }
}
