pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                // GitHub 또는 GitLab에서 코드 체크아웃
                git url: 'https://github.com/PSH989898/subject_option.git', branch: 'main' // 자신의 리포지토리와 브랜치로 변경
            }
        }
        stage('Copy Ansible Playbook to Master') {
            steps {
                // Ansible을 사용하여 마스터 노드에 플레이북 복사
                sh '''
                ansible -i /etc/ansible/hosts \
                -u your_user_name \
                --private-key /var/lib/jenkins/.ssh/ansible_key \
                copy src=/var/lib/jenkins/workspace/subject_jenkins/playbook.yml dest=/root/jen/playbook.yml
                '''
            }
        }
        stage('Deploy Docker Image on Master') {
            environment {
                ANSIBLE_HOST_KEY_CHECKING = 'False'
                ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key'
            }
            steps {
                // Ansible 플레이북을 실행하여 작업 수행
                sh '''
                ansible-playbook -i /etc/ansible/hosts master:/root/jen/playbook.yml
                '''
            }
        }
    }
}
