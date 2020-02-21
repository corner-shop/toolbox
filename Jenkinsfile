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
         steps {
             sh 'make registry-login toolbox-base'
         }
     }

     stage('make toolbox-gcc6') {
         steps {
             sh 'make registry-login toolbox-gcc6'
         }
     }

     stage('make toolbox-tools') {
         steps {
             sh 'make registry-login toolbox-tools'
         }
     }

     stage('make toolbox-latest') {
         steps {
             sh 'make registry-login toolbox-latest'
         }
     }
  }
}
