@Library ('My-Shared-Library@main') _

import groovy.json.*
import groovy.json.JsonSlurperClassic
import net.sf.json.groovy.JsonSlurper
import groovy.json.JsonOutput
import groovy.json.JsonBuilder
import groovy.io.FileType
import hudson.FilePath;
import jenkins.model.Jenkins;

pipeline {
    agent any 
    stages {
        stage("Checkout Code") {
            steps {
            scmCheckout("https://github.com/Kiranug/java-hello-world-with-maven.git","master","git_credentials")
            }
        }
            stage("Code Build") {
            steps {
            mvnbuild()
            }
        }
      stage ('Read Yaml') {
        steps {
            script {
                def config_json=libraryResource "appconfig/deveast.json"
	            def ConfigInputJSON = new JsonSlurperClassic().parseText(config_json)
				project_id = ConfigInputJSON."${Environment_Name}"."#PROJECT_ID#";
				deployment_credential_id = ConfigInputJSON."${Environment_Name}"."deployment_credential_id";
				build_credential_id = ConfigInputJSON."${Environment_Name}"."build_credential_id";
				cluster_name = ConfigInputJSON."${Environment_Name}"."cluster_name";
				cluster_region = ConfigInputJSON."${Environment_Name}"."cluster_region";
				jump_iap_server = ConfigInputJSON."${Environment_Name}"."jump_iap_server";
				jump_server_region = ConfigInputJSON."${Environment_Name}"."jump_server_region";
				AKS_RESOURCE_GROUP = ConfigInputJSON."${Environment_Name}"."AKS_RESOURCE_GROUP";
		  	        AKS_CLUSTER_NAME = ConfigInputJSON."${Environment_Name}"."AKS_CLUSTER_NAME";
		    		REGISTRY = ConfigInputJSON."${Environment_Name}"."REGISTRY";
				IMAGE = ConfigInputJSON."${Environment_Name}"."IMAGE";
		  	        TAG = ConfigInputJSON."${Environment_Name}"."TAG";
                println project_id
            	println deployment_credential_id
            	println cluster_name
            }
        }
     }
	stage ('Docker Build') {
        steps {
		withCredentials([usernamePassword(credentialsId: 'dockercred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
		sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
		sh "az acr login --name ${REGISTRY}"	
		sh 'az acr build --registry $REGISTRY --image ${IMAGE}:${BUILD_NUMBER} .'
		}
		//dockerbuild()
        }
     }	    
        stage('Deploy to AKS') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh "az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --file /opt/kuberconfig.yaml"
			sh "kubectl apply -f ${workspace}/DeploymentFiles/Deployment.yaml"
                }
            }
        }
   }
}
