pipeline {
    agent { node { label 'master' } }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage ("Terraform init") {
            steps {
                echo "Terraform init..."
                sh ("terraform init") 
            }
        }
        stage ("Network module plan") {
            steps {
        script {
            try {
                echo "Network module plan..."
                sh ('sudo terraform plan -target="module.aws_vpc"') 
                sh ('sudo terraform plan -target="module.aws_subnets"')
                sh ('sudo terraform plan -target="module.aws_sg"')
                sh ('sudo  terraform plan -target="module.aws_alb"')
                sh ('sudo  terraform plan -target="module.aws_dns"')
            } catch (err) {
                echo err.getMessage()
            }
        }
        echo currentBuild.result
    }
            
        }
        stage ("Backend module plan") {
            steps {
                echo "EC2 module plan..."
                sh ('sudo  terraform plan -target="module.aws_backend"') 
                
            }
        }

        // stage ("EC2 module plan") {
        //     steps {
        //         echo "EC2 module plan..."
        //         sh ('terraform plan -target="module.aws_bastion_host"') 
                
        //     }
        // }

        stage ("ECR module plan") {
            steps {
                echo "ECR module plan..."
                sh ('sudo terraform plan -target="module.aws_ecr"') 
            }
        }

        stage ("ECS module plan") {
            steps {
                echo "ECS module plan..."
                sh ('sudo terraform plan -target="module.aws_ecs_cluster"') 
                sh ('sudo terraform plan -target="module.aws_ecs_task_defenition"') 
                sh ('sudo terraform plan -target="module.aws_ecs_service"') 
                sh ('sudo terraform plan -target="module.aws_launch_template"') 
            }
        }

        stage ("IAM module plan") {
            steps {
                echo "IAM module plan..."
                sh ('sudo terraform plan -target="module.aws_iam"') 
            }
        }    

        stage ("Apply") {
            steps {
                echo "Apply"
                // sh ('sudo terraform apply --auto-approve') 
            }
        } 

        stage ("Trigger App build") {
            steps {
                echo "Trigger App Build"
                // build 'Demo3' 
            }
        } 

}
}