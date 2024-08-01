pipeline {
    agent any
    tools {
        maven "maven"
    }

    stages {
        stage("checkout code from vcs") {
            steps {
                checkout scm
            }
            post {
                success {
                    echo "[checkout]: successfully checked out code from vcs."
                }
                failure {
                    echo "[checkout]: failure to checked out code from vcs."
                }
            }
        }

        stage("run tests") {
            steps {
                sh 'mvn test'
            }
            post {
                success {
                    echo "[tests]: successfully run all tests."
                }
                failure {
                    echo "[tests]: one or more tests failed."
                }
            }
        }

        stage("build artifacts") {
            steps {
                sh 'mvn clean install'
            }
            post {
                success {
                    echo "[build]: successfully built artifacts."
                }
                failure {
                    echo "[build]: failure to build artifacts."
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}