pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git changelog: false, credentialsId: 'kranthi619', poll: false, url: 'https://github.com/kranthi619/Dev-Boardgame.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn compile -DskipTests=true"
            }
        }

        stage('Trivy Scan') {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=dev-project \
                        -Dsonar.projectName=dev-project \
                        -Dsonar.java.binaries=.'''
                }
            }
        }

        stage('Build') {
            steps {
                sh "mvn package -DskipTests=true"
            }
        }
    }
}
