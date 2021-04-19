pipeline {
    agent any
    environment { 
        registry = "ffswhy1" 
        registryCredential = 'agent-ssh-2' 
        dockerImage = 'flask_app' 
    }
    stages {
        stage('Tests'){
            pip install -e '.[test]'
            coverage run -m pytest
            coverage report
        }
        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + '/' + dockerImage + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                }
            }
        } 

    }
}
