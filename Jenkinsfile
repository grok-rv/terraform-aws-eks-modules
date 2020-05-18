import groovy.json.JsonOutput
env.terraform_version = '0.12.2'
pipeline {

   parameters {
    choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the eks cluster.')
    string(name: 'aws_region', defaultValue : 'us-west-2', description: "AWS region.")
    string(name: 'env', defaultValue: 'dev', description: "lab environment")
    string(name: 'rolename', defaultValue: 'aws-jenkins', description: "default aws role for jenkins")
    string(name: 'role-account', defaultValue: '534992115889', description: "default aws role account for jenkins")
    string(name: 'cluster', defaultValue: 'tl-eks-terraform', description: "eks cluster name")
    string(name: 'cidrblock', defaultValue : '10.123.0.0/16', description: "First 2 octets of vpc network; eg 10.0")
    string(name: 'cidr_public', defaultValue: '["10.123.1.0/24","10.123.2.0/24"]', description: "cidr block for public subnets")
    string(name: 'cidr_private', defaultValue: '["10.123.3.0/24","10.123.4.0/24"]', description: "cidr block for private subnets")


  }

  options {
    disableConcurrentBuilds()
    timeout(time: 1, unit: 'HOURS')
  }

  agent { label 'master' }

  stages {

    stage('Setup') {
      steps {
        script {
          currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + params.cluster
          //plan = params.cluster + '.plan'
        }
      }
    }

    stage('Install dependencies') {
      steps {
        sh "sudo yum install wget zip python-pip -y"
        sh "cd /tmp"
        sh "curl -o terraform.zip https://releases.hashicorp.com/terraform/'$terraform_version'/terraform_'$terraform_version'_linux_amd64.zip"
        sh "unzip terraform.zip"
        sh "sudo mv terraform /usr/bin"
        sh "rm -rf terraform.zip"
        sh "terraform version"
      }
    }

    stage('Git checkout') {
       steps {
         dir('tl-eks-terraform') {
           git branch: 'master', credentialsId: '', url: 'https://github.nikecom/CIS/tl-eks-terraform.git'
         }
       }
    }


    stage('Terraform dev plan') {
      when {
        expression { params.action == 'create' && params.env == 'dev' }
      }
      steps {
       dir('tl-eks-terraform/environments/dev') {
        script {
          withAWS([profile:${params.env}, region:${params.aws_region}, role:${params.rolename}, roleAccount:${params.role-account}]) {

            sh "terraform init"
            sh "terraform plan -out tfplan"
          }
        }
       }
      }
    }


    stage('Terraform prod plan') {
      when {
        expression { params.action == 'create' && params.env == 'prod' }
      }
      steps {
        dir('tl-eks-terraform/environments/prod') {
          script {
            withAWS([profile:${params.env}, region:${params.aws_region}, role:${params.rolename}, roleAccount:${params.role-account}]) {
                sh "terraform init"
                sh "terraform plan -out tfplan"
            }
          }
        }
      }
    }

    stage('TF Apply') {
      when {
        expression { params.action == 'create' && params.env == 'dev'}
      }
      steps {
       dir('tl-eks-terraform/environments/dev') {
        script {
          input "Create/update Terraform stack eks-${params.cluster} in aws?"

          withAWS([profile:${params.env}, region:${params.aws_region}, role:${params.rolename}, roleAccount:${params.role-account}]) {
            sh "terraform apply -input=false -auto-approve tfplan"

          }
        }
       }
      }
    }

    stage('TF Destroy') {
      when {
        expression { params.action == 'destroy' }
      }
      steps {
       dir('tl-eks-terraform') {
        script {
          input "Destroy Terraform stack eks-${params.cluster} in aws?"

          withAWS([profile:${params.env}, region:${params.aws_region}, role:${params.rolename}, roleAccount:${params.role-account}]) {
            sh "terraform destroy -auto-approve"

          }
        }
       }
      }
    }

  }

}
