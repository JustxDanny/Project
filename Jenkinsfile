pipeline {
    agent {
        label "slave1"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/JustxDanny/Project.git',
                        credentialsId: 'credentials-ssh-id'
                    ]]
                ])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-app .'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'docker run my-app npm test'
            }
        }
        stage('Save Test Results') {
            steps {
                script {
                    def userName = env.USER
                    def currentDate = new Date().format("yyyy-MM-dd")
                    def testStatus = sh(returnStatus: true, script: 'docker run my-app npm test')
                    def csvContent = "${userName},${currentDate},${testStatus}"
                    writeFile file: 'test_results.csv', text: csvContent, encoding: 'UTF-8'
                }
            }
        }
        stage('Upload CSV to S3') {
            steps {
                withAWS(credentials:'DanielDevops', region:'eu-central-1') {
                    s3Upload(file: 'test_results.csv', bucket:'danielproject', path: 'test_results.csv')
                }
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
