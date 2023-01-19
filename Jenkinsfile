pipeline {
  agent any

  tools {
    jdk 'Java'
    maven 'Maven'
  }
  
  environment {

      sonar_url = 'http://10.128.0.3:9000'
      sonar_username = 'admin'
      sonar_password = 'admin'
      nexus_url = '10.128.0.5:8081'
      artifact_version = '4.0.0'

 }
 //parameters {
 //     string(defaultValue: 'master', description: 'Please type any branch name to deploy', name: 'Branch')
// }  

stages {
    stage('Git checkout'){
      steps {
        git branch: 'main',
        url: 'https://github.com/Bharak786/sprigboot.git'
      }
    }
    stage('Maven build'){
      steps {
        sh 'mvn clean install'
      }
    }
    stage ('Sonarqube Analysis'){
           steps {
           withSonarQubeEnv('Sonarqube') {
           sh '''
           mvn -e -B sonar:sonar -Dsonar.java.source=1.8 -Dsonar.host.url="${sonar_url}" -Dsonar.login="${sonar_username}" -Dsonar.password="${sonar_password}" -Dsonar.sourceEncoding=UTF-8
           '''
           }
         }
      } 
      stage ('Publish Artifact') {
        steps {
          nexusArtifactUploader artifacts: [[artifactId: 'spring-boot-starter-parent', classifier: '', file: "target/devOps-0.0.1-SNAPSHOT.jar", type: 'jar']], credentialsId: 'nexus-cred', groupId: 'org.springframework.boot', nexusUrl: "${nexus_url}", nexusVersion: 'nexus3', protocol: 'http', repository: 'release', version: "${artifact_version}"
        }
      }
      stage ('Build Docker Image'){
        steps {
          sh '''
          cd ${WORKSPACE}
          docker build -t gcr.io/umar-poc/springboot --file=Dockerfile ${WORKSPACE}
          '''
        }
      }
      stage ('Publish Docker Image'){
        steps {
          sh '''
          docker push gcr.io/umar-poc/springboot
          '''
        }
      }
      stage ('Deploy to kubernetes'){
        steps{
          script {
            sh "kubectl config use-context gke_umar-poc_us-central1-c_umar-poc"
            sh "cd ${WORKSPACE}"
            sh "kubectl delete -f '${WORKSPACE}'/kube/deployment.yaml"
            sh "kubectl apply -f '${WORKSPACE}'/kube/deployment.yaml"
            sh "kubectl apply -f '${WORKSPACE}'/kube/service.yaml"
          }
         }
        }
   }
}
