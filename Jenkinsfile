pipeline {
    agent {
        kubernetes {
            yamlFile 'k8s-kaniko-pod.yaml'
        }
    }

    stages {
        stage("build") {
            steps {
                container("kaniko") {
                    sh """
                        /kaniko/executor --dockerfile `pwd`/Dockerfile --context `pwd` --destination=docker-r.nexus.s3t.co/smart-web-bot-agent:latest --skip-tls-verify --skip-tls-verify-pull
                    """
                }
            }
        }
    }
}