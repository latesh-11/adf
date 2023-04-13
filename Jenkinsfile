pipeline{
    agent any
    stages{
        stage("Git checkout"){
            steps{
                echo "========executing Git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/demo-app.git'
            }
        }
        stage("UNIT Testing"){
            steps{
                echo "========executing Maven Test========"

                sh 'maven test'


            }
        }
        stage("C"){
            steps{
                echo "========executing A========"
            }
        }
        stage("D"){
            steps{
                echo "========executing A========"
            }
        }
        stage("E"){
            steps{
                echo "========executing A========"
            }
        }
        stage("F"){
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
