pipeline {
    agent {label 'agent'}
    environment { 
        registry = "ffswhy1" 
        registryCredential = 'x' 
        dockerImage = 'flask_app' 
    }
    stages {
        stage ('Tests')  {
            steps ('Steps'){
                sh"""
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -e .
                    export FLASK_APP=js_example
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                    deactivate
                 """
           }
    }
            
            
        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + '/' + dockerImage + ":$BUILD_NUMBER" 
                    sh 'echo Build Number = $BUILD_NUMBER'
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
             build (job: "${http:%2F%2F192.168.56.112:8080/job/Test%20Pipeline%20CD/}", parameters: {
             {
              $class: 'StringParameterValue',
              name: 'BUILD_NUMBER',
              value: "${env.BUILD_NUMBER}"
             }
            }
        } 

    }
}
