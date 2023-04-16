pipeline{
    agent any
    stages{
        stage("Git checkout"){
            steps{
                echo "========executing Git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/demo-app.git'
            }
        }
        stage("Maven UNIT Testing"){
            steps{
                echo "========executing Maven Test========"

                sh 'mvn test'


            }
        }
        stage("Maven Integration testing"){
            steps{
                echo "========executing Integration testing========"
                sh 'mvn verify -DskipUnitTest'
            }
        }
        stage("Maven build"){
            steps{
                echo "========executing Maven Build========"
                sh 'mvn clean install'
            }
        }
        stage("SonarQube analysis"){
            steps{
                 echo "========executing static code analysis========"
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-api-key') {
                    sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage("Quality Gate Status"){
            steps{
                echo "========executing Quality Gate Status========"
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api-key' 
                }
            }
        }
         stage("upload warfile to nexus"){
            steps{
                echo "========executing upload warfile to nexus========"
                script{
                    nexusArtifactUploader artifacts: [
                        [
                            artifactId: 'springboot', classifier: '',
                             file: 'target/Uber.jar', 
                             type: 'jar'
                            ]
                        ], 
                        credentialsId: '9167ac14-c357-44c3-bc27-5f05c6f164c4',
                        groupId: 'com.example', 
                        nexusUrl: '192.168.1.7:8081',
                        nexusVersion: 'nexus2',
                        protocol: 'http', 
                        repository: 'demoapp-release', 
                        version: '1.0.0'
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
