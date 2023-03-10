pipeline {
    agent any
    stages {
        stage('Build on agent2') {
            agent {
                node {
                    label 'agent2'
                }
            }
            steps {
                sh 'echo "Building on agent2"'
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
                userRemoteConfigs: [[credentialsId: 'master-node2', url: 'git@github.com:JustxDanny/Project.git']]
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
