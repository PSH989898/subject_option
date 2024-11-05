pipeline {
  agent any
  environment {
    ANSIBLE_HOST_KEY_CHECKING = 'False'
    ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key' // 필요한 경우 사용
  }
  stages {
    stage('Checkout') {
      steps {
        // 코드 체크아웃
        checkout scm
      }
    }
    stage('Build and Push Docker Image') {
      steps {
        script {
          // Docker 이미지를 빌드하고 Docker Hub에 푸시
          sh '''
            docker build -t pshhhhh98/subject:jenkin .
            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
            docker push pshhhhh98/subject:jenkin
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
      node {
        cleanWs()
      }
    }
    failure {
      echo '배포 실패!'
    }
  }
}
