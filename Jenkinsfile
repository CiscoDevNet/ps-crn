pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            args  '-v /etc/passwd:/etc/passwd'
        }
    }
    options {
      disableConcurrentBuilds()
      lock resource: 'viptela-workshop-testbed'
    }
    environment {
        VIRL_USERNAME = credentials('cpn-virl-username')
        VIRL_PASSWORD = credentials('cpn-virl-password')
        VIRL_HOST = credentials('cpn-virl-host')
        VIPTELA_ORG = credentials('viptela-org')
        HOME = "${WORKSPACE}"
        DEFAULT_LOCAL_TMP = "${WORKSPACE}/ansible"
    }
    stages {
        stage('Build VIRL Topology') {
           steps {
                echo 'Running build.yml...'
                ansiblePlaybook disableHostKeyChecking: true, extras: "-e virl_tag=jenkins", playbook: 'build.yml'
                echo 'Configure licensing...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'configure-licensing.yml'
           }
        }
        stage('Configure SD-WAN Fabric') {
           steps {
                echo 'Configure Viptela Control Plane...'
                withCredentials([file(credentialsId: 'viptela-serial-file', variable: 'VIPTELA_SERIAL_FILE')]) {
                    ansiblePlaybook disableHostKeyChecking: true, extras: '-e virl_tag=jenkins -e \'organization_name="${VIPTELA_ORG}"\' -e serial_number_file=${VIPTELA_SERIAL_FILE} -e viptela_cert_dir=${WORKSPACE}/myCA', tags: 'control', playbook: 'configure.yml'
                }
                echo 'Configure Viptela Edge...'
                withCredentials([file(credentialsId: 'viptela-serial-file', variable: 'VIPTELA_SERIAL_FILE')]) {
                    ansiblePlaybook disableHostKeyChecking: true, extras: '-e virl_tag=jenkins -e \'organization_name="${VIPTELA_ORG}"\' -e serial_number_file=${VIPTELA_SERIAL_FILE} -e viptela_cert_dir=${WORKSPACE}/myCA', tags: 'edge', playbook: 'configure.yml'
                }
                echo 'Loading Templates...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'import-templates.yml'
                echo 'Waiting for vEdges to Sync...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'waitfor-sync.yml'
                echo 'Attaching Templates...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'attach-template.yml'
                echo 'Loading Policy...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'import-policy.yml'
                echo 'Activating Policy...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'activate-policy.yml'
           }
        }
        stage('Validate') {
           steps {
                echo 'Loading Templates...'
                ansiblePlaybook disableHostKeyChecking: true, playbook: 'check-sdwan.yml'
           }
        }
    }
/*
    post {
        always {
            ansiblePlaybook disableHostKeyChecking: true, playbook: 'clean.yml'
            cleanWs()
        }
    }
*/
}

