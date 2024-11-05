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
        ansible-playbook -i /etc/ansible/hosts /var/lib/jenkins/workspace/ansible/playbook.yml
        '''
      }
    }
  }
}
