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
                checkout([
                    $class: 'GitSCM',
                    branches: [
                        [name: 'main']
                    ],
                    userRemoteConfigs: [
                        [
                            url: 'git@github.com:JustxDanny/Project.git',
                            credentialsId: 'master-node'
                        ]
                    ],
                    extensions: [
                        [$class: 'CloneOption', depth: 1]
                    ]
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
