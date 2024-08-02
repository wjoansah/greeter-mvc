def container_name = "greeter-mvc"
def image_name = "greeter-mvc"

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
                    echo "[checkout]: failed to checkout code from vcs."
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
                    echo "[tests]: tests run failed."
                }
            }
        }

        stage("build artifacts") {
            steps {
                sh 'mvn clean install'
            }
            post {
                success {
                    echo "[artifacts-build]: successfully built artifacts."
                }
                failure {
                    echo "[artifacts-build]: failed to build artifacts."
                }
            }
        }

        stage("build docker image") {
            steps {
                script {
                    sh "docker stop ${container_name}"
                    sh "docker rm ${container_name}"
                    sh "docker rmi ${image_name}"
                    sh "docker build -t ${image_name} --no-cache ."
                }
            }
            post {
                success {
                    echo "[docker-build]: successfully built docker image."
                }
                failure {
                    echo "[docker-build]: failed to build docker image."
                }
            }
        }

        stage("run docker image") {
            steps {
                sh "docker run -d -p 3001:3001 --name ${container_name} ${image_name}"
            }

            post {
                success {
                    echo "[docker-run]: successfully run docker image."
                }
                failure {
                    echo "[docker-run]: failed to run docker image."
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