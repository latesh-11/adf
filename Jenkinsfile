pipeline{
    agent any
    stages{
       stage("Git checkout"){
            steps{
                echo "========executing Git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/demo-app.git'
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