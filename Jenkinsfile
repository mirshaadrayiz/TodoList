pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        GIT_CREDENTIALS = 'git-hub-credentials'
        IMAGE_NAME = 'mirshaad98/todo-list'
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }
    
    stages {
        stage('Pull Source Code') {
            steps {
                git branch: 'main', credentialsId: GIT_CREDENTIALS, url: 'https://github.com/mirshaadrayiz/TodoList.git'
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    // Stop and remove any existing containers
                    sh 'docker-compose down || true'
                    // Remove old images to avoid using the cache
                    sh "docker rmi \$(docker images -q ${IMAGE_NAME}) || true"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and use a cache-busting technique
                    docker.build("${IMAGE_NAME}", "--no-cache .")
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
                    // Deploy the application using Docker Compose
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d --build --force-recreate"
                }
            }
        }
    }
}
