pipeline{
    agent any

    parameters {
        choice(name:'action' , choices:['create','destroy','destroyekscluster'] , description: 'create/update or destroy eks cluster')
        string(name: 'cluster' , defaultValue: 'demo-cluster' , description: 'EKS cluster name')
        string(name: 'region' , defaultValue: 'us-east-1' , description: 'EKS cluster region')
    }
    environment {
        ACCESS_KEY = credentials('aws_access_key-id')
        SECRET_KEY = credentials('aws_secret_access_key')
    }
    }
    stages{
       stage("Git checkout"){
            steps{
                echo "========executing Git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/demo-app.git'
            }
        }
         stage("eks connect"){
            steps{
                echo "========executing eks connect========"
                sh """
                    aws configure set aws_access_key_id "$(ACCESS_key)"
                    aws configure set aws_secret_access_key "$(SECRET_KEY)"
                    aws configure set region ""
                    aws eks --region $(params.region) update-kubeconfig --name $(params.cluster)


                    """
                
            }
        }
        stage("eks deployment"){
            when { expression { params.action == 'create' } }
            steps{
                echo "========executing eks deployment========"

                script{
                    def apply = false
                    try{
                        input massage: 'please confirm the apply to initita the deployments', ok: 'Ready to apply the config'
                        apply = true
                    }        
                catch(err){
                    apply = false
                    CurrentBuild.result = 'UNSTABLE'
                }
                if(apply){
                    // deploy all manifest files
                    sh """
                        kubectl apply -f .
                        """

                }
                }


            }
        }
         stage("delete deployment"){
            when {expression {params.action == 'destroy'}}
            steps{
                echo "========executing delete deployment========"

                script {
                    def destroy = falce

                    try{
                        input massage: 'please confirm the destroy to delete the deployments' , ok: 'Ready to destroy the config'
                        destroy = true
                    }
                    catch(err){
                        destroy = false
                        CurrentBuild.result= 'UNSTABLE'
                    } 
                    if(destroy){
                        sh """
                            kubectl delete -f .
                            """
                    }
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