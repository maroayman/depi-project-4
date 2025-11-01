pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-1' // change as needed
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/maroayman/depi-project-4.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve deployment?', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}

