pipeline {
    agent any
    options {
        disableConcurrentBuilds()
    }
    stages {
        stage('Create Folder') {
            steps {
                sh 'sudo rm -rf /projectBUILD/'
                sh 'sudo mkdir /projectBUILD/'
                sh 'sudo chown -R jenkins:jenkins /projectBUILD/'
                sh 'sudo chmod -R 755 /projectBUILD'
            }
        }
        stage('Checkout SCM') {
            steps {
                dir('/home/ubuntu/workspace/projectBUILD') {
                    sh 'echo "CheckoutSCM"'
                    checkout([$class: 'GitSCM',
                        branches: [[name: 'main']],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'SubmoduleOption',
                            disableSubmodules: false,
                            parentCredentials: true,
                            recursiveSubmodules: true,
                            reference: '',
                            trackingSubmodules: false]],
                        submoduleCfg: [],
                        userRemoteConfigs: [[credentialsId: 'master-node2',
                            url: 'git@github.com:JustxDanny/Project.git']]
                    ])
                }
            }
        }
        stage('S3download') {
            steps {
              sh 'rm -f 3kyx3yqbo4ycdgxi5jc3n5pomy.json.gz' // only delete the specific file
              withAWS(credentials: 'DanielDevops', region: 'eu-central-1') {
                s3Download(file: '3kyx3yqbo4ycdgxi5jc3n5pomy.json.gz',
                  bucket: 'danielproject',
                  path: "AWSDynamoDB/01677951784753-854cdf64/data/3kyx3yqbo4ycdgxi5jc3n5pomy.json.gz")
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('/home/ubuntu/workspace/projectBUILD') {
                    sh 'docker build -t my-app:1.0.0 .'
                    sh "docker run -p 80:80 my-app:1.0.0"
                }
            }
        }
//         stage('Run Unit Tests') {
//             steps {
//                 dir('/home/ubuntu/workspace/projectBUILD/Project') {
//                     sh 'docker run my-app:1.0.0 npm test -- --xml test-results.xml'
//                     sh 'docker cp $(docker ps -lq):/home/node/app/test-results.xml /home/ubuntu/workspace/projectBUILD/' 
//                 }
//             }
//         }
        stage('PreUploadToGit') {
            steps {
                sh 'gzip -d 3kyx3yqbo4ycdgxi5jc3n5pomy.json.gz'
                sh 'git add .'
                sh 'git commit -m "some commit message"'
            }
        }
        stage('GitPush') {
            steps {
                sh 'git push origin HEAD'
            }
        }
//         stage('Upload CSV to S3') {
//             steps {
//                 script {
//                     def userName = env.USER
//                     def currentDate = new Date().format("yyyy-MM-dd")
//                     def testStatus = currentBuild.result == 'SUCCESS' ? 'Passed' : 'Failed'
//                     def csvContent = "${userName},${currentDate},${testStatus}"
//                     writeFile file: 'test_results.csv', text: csvContent, encoding: 'UTF-8'
//                 }
//                 withAWS(credentials: 'DanielDevops', region: 'eu-central-1') {
//                     s3Upload(file: 'test_results.csv',
//                         bucket: 'danielproject',
//                         path: 'test_results.csv')
//                 }
//             }
//         }
    }
    post {
        always {
            deleteDir()
        }
    }
}
