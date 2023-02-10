ecr-login:
	aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin ${ECR_REPO}
build-image:
	docker build -t ${ECR_REPO}:${IMAGE_TAG} .
	docker tag ${ECR_REPO}:${IMAGE_TAG} ${ECR_REPO}:latest	
	docker push -a ${ECR_REPO}

deploy-task:
# aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment
#ecs deploy ${CLUSTER_NAME} ${SERVICE_NAME} --tag ${IMAGE_TAG}
	ecs deploy ${CLUSTER_NAME} ${SERVICE_NAME} --image ${CONTAINER_NAME} "${ECR_REPO}:${IMAGE_TAG}"