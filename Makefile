# IMAGE_TAG := $(CIRCLE_SHA1)
$(eval GITHUB_COMMIT_SHA=$(shell git rev-parse HEAD))
$(eval IMAGE_TAG=$(shell echo $(GITHUB_COMMIT_SHA:0:7)))
print:
	@echo "GITHUB_COMMIT_SHA: $(GITHUB_COMMIT_SHA)"
	@echo "IMAGE_TAG: $(IMAGE_TAG)"


ecr-login:
	aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin ${ECR_REPO}

build-image:ecr-login
# docker build -t ${ECR_REPO}:${IMAGE_TAG} .
	docker build -t ${ECR_REPO_FLASK}:${IMAGE_TAG} .
# docker tag ${ECR_REPO}:${IMAGE_TAG} ${ECR_REPO}:latest	
	docker push ${ECR_REPO_FLASK}:${IMAGE_TAG}

# deploy-task:
# # aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment
# 	ecs deploy ${CLUSTER_NAME} ${SERVICE_NAME} --tag ${IMAGE_TAG} 
# # ecs deploy ${CLUSTER_NAME} ${SERVICE_NAME} --image ${CONTAINER_NAME} "${ECR_REPO}:${IMAGE_TAG}"