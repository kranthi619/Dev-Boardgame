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

        stage('Deploy Artifacts to Nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'maven-settings', jdk: 'jdk17', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                    sh "mvn deploy -DskipTests=true"
                }
            }
        }

        stage('Docker Image Creation') {
            steps {
                echo 'Building Docker image using Dockerfile'
                sh 'docker build -t kranthi619/dev-project .'
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format table -o trivy-image-report.html kranthi619/dev-project:latest"
            }
        }

        stage('Docker Login and Push') {
            steps {
                echo 'Logging in to Docker Hub'
                sh 'docker login -u kranthi619 -p Kranthi123#'
                sh 'docker push kranthi619/dev-project'
            }
        }
    }
}
