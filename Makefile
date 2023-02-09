ecr-login:
	aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin ${ECR_REPO}

build-image:
	docker build -t app .