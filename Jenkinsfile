#Jenkinsfile

pipeline {
  agent any
  stages {
    stage('Deploy Docker Image on Master') {
      environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        ANSIBLE_PRIVATE_KEY_FILE = '/var/lib/jenkins/.ssh/ansible_key'
      }
      steps {
        sh '''
        #                                          이 경로 확인해서 넣을것!! 여기 실제 젠킨스가 설치된 서버의 경로임 ansible 말고 젠킨스에서 만들때 지정한 프로젝트 이름이 될거임
        ansible-playbook -i /etc/ansible/hosts /var/lib/jenkins/workspace/subject_jenkins/playbook.yml
        '''
      }
    }
  }
}
