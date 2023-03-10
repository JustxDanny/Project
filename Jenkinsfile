pipeline {
    agent any
    stages {
        stage('Build on agent1') {
            agent {
                node {
                    label 'agent1'
                    customWorkspace '/home/johnsmith/myworkspace'
                }
            }
            steps {
                sh 'echo "Building on agent1"'
            }
        }
        stage('Checkout SCM') {
            steps {
                sh 'echo "CheckoutSCM"'
                checkout([$class: 'GitSCM',
                branches: [[name: '*main']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: true, recursiveSubmodules: true, reference: '', trackingSubmodules: false]],
                submoduleCfg: [],
                userRemoteConfigs: [[credentialsId: 'master-ubuntu', url: 'git@github.com:JustxDanny/Project.git']]
                         ])
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
