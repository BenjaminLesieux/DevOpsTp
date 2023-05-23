pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/BenjaminLesieux/DevOpsTp.git'
            }
        }

        stage('install node dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('run tests') {
            steps {
                sh 'npm run test'
            }
        }

        stage('build') {
            steps {
                sh 'npm run build'
            }
        }

        // stage publish 
    }
}