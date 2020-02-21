pipeline {
    agent any
    environment {
             CI_REGISTRY_USER = credentials('GITLAB_REGISTRY_USER')
             CI_REGISTRY_PASSWORD = credentials('GITLAB_REGISTRY_PASSWORD')
             CI_REGISTRY = 'registry.gitlab.com/thecornershop'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '8'))
        disableConcurrentBuilds()
        newContainerPerStage()
        overrideIndexTriggers(true)
        preserveStashes(buildCount: 5)
        quietPeriod(30)
        skipStagesAfterUnstable()
        timestamps()
        parallelsAlwaysFailFast()
    }
    triggers {
         cron('H * * * *')
         pollSCM('H * * * *')
    }
    stages {
     stage('make toolbox-base') {
         options {
             timeout(time: 30, unit: 'MINUTES')
             retry(3)
             timestamps()
         }
         steps {
             sh 'make registry-login toolbox-base'
         }
     }

     stage('make toolbox-gcc6') {
         options {
             timeout(time: 9, unit: 'HOURS')
             retry(1)
             timestamps()
         }
         steps {
             sh 'make registry-login toolbox-gcc6'
         }
     }

     stage('make toolbox-tools') {
         options {
             skipDefaultCheckout()
             timeout(time: 2, unit: 'HOURS')
             retry(1)
             timestamps()
         }
         steps {
             sh 'make registry-login toolbox-tools'
         }
     }

     stage('make toolbox-latest') {
         options {
             timeout(time: 1, unit: 'HOURS')
             retry(1)
             timestamps()
         }
         steps {
             sh 'make registry-login toolbox-latest'
         }
     }
  }
}
