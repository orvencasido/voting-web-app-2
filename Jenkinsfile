pipeline {
	agent any

	environment{
		DOCKER_IMAGE = "vote-app-2"
	}

	stages{
		stage('Clone Repository'){
			steps{
				git branch: 'main', url: 'https://github.com/orvencasido/voting-web-app-2'
			}
		}

		stage('Build Docker'){
			steps{
				script{
					sh "docker build -t ${DOCKER_IMAGE} ."
				}
			}
		}

		stage('Stop Existing Containers'){
			steps{
				script{
					sh "docker stop ${DOCKER_IMAGE}"
					sh "docker rm ${DOCKER_IMAGE}"
				}
			}
		}

		stage('Check Redis'){
			steps{
				script{
					sh '''
						if [ "$(docker ps -q -f name=redis)" = "" ]; then
							if [ "$(docker ps -aq -f status=exited -f name=redis)" != "" ]; then
								docker start redis
							else 
								docker run -d --name redis redis:alpine
							fi
						fi
					'''
				}
			}
		}

		stage('Run the Container'){
			steps{
				script{
					sh "docker run -d -p 5000:5000 --link redis --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}"
				}
			}
		}
	}

	post {
		success {	
			echo "DEPLOYEMENT SUCCESSFUL!"
		}

		failure {
			echo "DEPLOYEMENT FAILED!"			
		}	
	}
}
