pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        GIT_CREDENTIALS = 'git-hub-credentials'
        IMAGE_NAME = 'your-dockerhub-username/todo-list'
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }
    
    stages {
        stage('Pull Source Code') {
            steps {
                git branch: 'main', credentialsId: GIT_CREDENTIALS, url: 'https://github.com/mirshaadrayiz/TodoList.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build IMAGE_NAME
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        docker.image(IMAGE_NAME).push()
                    }
                }
            }
        }
        
        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
                }
            }
        }
    }
}
