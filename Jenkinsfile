pipeline {
    agent any
    tools {
        terraform 'terraform-11'
    }

    stages {
        stage('Setup Parameters') {
            steps {
                script {
                    properties([
                        parameters([
                            string(
                                defaultValue: 'deploy-grafana-eks',
                                description: 'This parameter decides the name of terraform workspace',
                                name: 'NAME_TF_WORKSPACE'
                            )
                        ])
                    ])
                }
            }
        }

        stage('Git Checkout') {
            steps {
                git credentialsId: 'c94f1316-a4c0-4691-b147-32f390296144', url: 'https://github.com/VietNguyen408/deploy-grafana-eks'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh '''
                    terraform init 
                    terraform workspace select ${NAME_TF_WORKSPACE} || terraform workspace new ${NAME_TF_WORKSPACE}
                    terraform workspace show
                    terraform workspace list
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh '''
                    terraform apply --auto-approve
                    '''
                }
            }
        }
    }
}