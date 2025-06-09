---

## 🧪 Paso 3: Jenkinsfile para CI/CD

```groovy
pipeline {
    agent any

    environment {
        registry = "dockerhub_usuario/miapp"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                git 'https://github.com/usuario/miapp.git'
            }
        }

        stage('Análisis de Código con SonarQube') {
            steps {
                script {
                    scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Escaneo de Vulnerabilidades con Trivy') {
            steps {
                script {
                    sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL dockerhub_usuario/miapp:latest'
                }
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }

        stage('Subir Imagen a Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Desplegar en Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'kubeconfig-raw', serverUrl: 'https://kubernetes.default.svc']) {
                        sh 'kubectl apply -f k8s/deployment.yaml'
                        sh 'kubectl apply -f k8s/service.yaml'
                    }
                }
            }
        }

        stage('Verificar Despliegue') {
            steps {
                script {
                    sh 'kubectl get pods'
                    sh 'kubectl get svc'
                }
            }
        }
    }
    stage('Escaneo de Configuraciones con Kubescape') {
        steps {
            script {
                sh 'kubescape scan --exclude-namespaces kube-system,kube-public --format junit --output results.xml .'
            }
        }
    }
}
}
