pipeline {
    agent any

    stages {
        stage('install node dependencies') {
            steps {
                sh 'cd /var/jenkins_home/workspace/DevOpsTp'
                sh 'npm install'
            }
        }

        stage('run tests') {
            steps {
                sh 'cd /var/jenkins_home/workspace/DevOpsTp'
                sh 'npm run test'
            }
        }

        stage('build') {
            steps {
                sh 'cd /var/jenkins_home/workspace/DevOpsTp'
                sh 'npm run build'
            }
        }

        // stage publish
    }
}