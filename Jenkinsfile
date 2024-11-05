pipeline {
    agent any
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                // 예: Maven 빌드
                sh 'mvn clean package'
            }
        }
        stage('Deploy Docker Image on Master') {
            steps {
                sh '''
                ansible-playbook -i /etc/ansible/hosts /var/lib/jenkins/workspace/subject_jenkins/playbook.yml --private-key=$ANSIBLE_PRIVATE_KEY_FILE
                '''
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo '배포 성공!'
        }
        failure {
            echo '배포 실패!'
        }
    }
}
