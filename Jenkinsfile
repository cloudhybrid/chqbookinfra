ansiColor('xterm') {
    properties ([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')),
        [$class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false],
        disableConcurrentBuilds(),
        parameters([choice(choices: 'us-east-1\nus-east-2\nus-west-1\nus-west-2\nap-south-1', description: 'Region in which you want to deploy code', name: 'Region'),
        choice(choices: 'management\nprod', description: 'ENV in which you want to deploy code Management or Prod', name: 'Environment'),
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
            echo "terraform init"
        }

        stage("Plan the infra with terraform")
        {
            echo "terraform plan -var region=${Region} -var profile=${Iam_Profile}"

            mail(to: 'abhishek.dubey@opstree.com',
                subject: "${currentBuild.fullDisplayName} is ready for deployment",
                body: "Please approve the URL: ${env.BUILD_URL}input")

            input message: 'Do you want to deploy terraform code on '"${Environment}"'?', submitterParameter: 'Action'
        }
    }
}
