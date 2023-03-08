pipeline {
    agent any
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
                sh 'docker build -t my-app:1.0.0 .'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'docker run my-app:1.0.0 npm test -- --xml test-results.xml'
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
        stage('Upload CSV to S3') {
            steps {
                script {
                    def userName = env.USER
                    def currentDate = new Date().format("yyyy-MM-dd")
                    def testStatus = currentBuild.result == 'SUCCESS' ? 'Passed' : 'Failed'
                    def csvContent = "${userName},${currentDate},${testStatus}"
                    writeFile file: 'test_results.csv', text: csvContent, encoding: 'UTF-8'
                }
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
