pipeline {
    agent {label 'agent'}
    environment { 
        registry = "ffswhy1" 
        registryCredential = 'agent-ssh-2' 
        dockerImage = 'flask_app' 
    }
    stages {
        stage ('Tests')  {
            steps ('Steps'){
                sh"""
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                 """
           }
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
