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
                echo "========executing A========"
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api-key' 
                }
            }
        }
         stage("g"){
            steps{
                echo "========executing A========"
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
