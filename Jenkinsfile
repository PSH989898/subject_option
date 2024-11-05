pipeline {
    agent any  // 모든 에이전트에서 실행
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key'
        DOCKER_USERNAME = credentials('docker-username') // Jenkins에 등록된 Docker 사용자 이름
        DOCKER_PASSWORD = credentials('docker-password') // Jenkins에 등록된 Docker 비밀번호
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Docker 이미지를 빌드하고 Docker Hub에 푸시
                    sh '''
                        docker build -t pshhhhh98/subject:jenkin .
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push pshhhhh98/subject:jenkin
                    '''
                }
            }
        }
        stage('Deploy Docker Image on Master') {
            steps {
                script {
                    sh '''
                        ansible-playbook -i /etc/ansible/hosts /var/lib/jenkins/workspace/subject_jenkins/playbook.yml
                    '''
                }
            }
        }
    }
    post {
        always {
            script {
                cleanWs() // 이곳을 node 블록으로 감쌉니다.
            }
            echo '배포 완료!'
        }
        failure {
            echo '배포 실패!'
        }
    }
}
