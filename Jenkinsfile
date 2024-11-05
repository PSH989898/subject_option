pipeline {
  agent any
  environment {
    ANSIBLE_HOST_KEY_CHECKING = 'False'
    ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key' // 필요한 경우 사용
    DOCKER_USERNAME = credentials('docker-username') // Jenkins의 비밀 관리 사용
    DOCKER_PASSWORD = credentials('docker-password') // Jenkins의 비밀 관리 사용
  }
  stages {
    stage('Checkout') {
      steps {
        // 코드 체크아웃
        checkout scm
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          // Docker 이미지를 빌드
          sh '''
            docker build -t pshhhhh98/subject:jenkin .
          '''
        }
      }
    }
    stage('Deploy Docker Image on Master') {
      steps {
        // Ansible 플레이북을 실행하여 배포
        sh '''
          ansible-playbook -i /etc/ansible/hosts /var/lib/jenkins/workspace/subject_jenkins/playbook.yml
        '''
      }
    }
  }
  post {
    always {
      // 작업 공간 정리
      cleanWs()
    }
    failure {
      echo '배포 실패!'
    }
  }
}
