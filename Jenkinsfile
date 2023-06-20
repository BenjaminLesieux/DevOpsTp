pipeline {
    agent docker {
            image 'node:latest'
        }
    }
    stages {
        stage('Checkout') {
          steps {
            checkout scm
          }
        }
        stage('Environment') {
          steps {
              sh 'git --version'
              echo "Branch: ${env.BRANCH_NAME}"
              sh 'docker -v'
              sh 'printenv'
          }
        }
        stage('Build Docker test'){
           steps {
                    sh 'docker build -t react-test -f Dockerfile.test --no-cache .'
           }
        }
        stage('Docker test'){
          steps {
            sh 'docker run --rm react-test'
          }
        }
        stage('Clean Docker test'){
          steps {
            sh 'docker rmi -f react-test'
          }
        }
        stage('Deploy'){
          steps {
            sh 'docker build -t react-app --no-cache .'
            sh 'docker tag react-app localhost:5000/react-app'
            sh 'docker push localhost:5000/react-app'
            sh 'docker rmi -f react-app localhost:5000/react-app'
          }
        }
    }
}