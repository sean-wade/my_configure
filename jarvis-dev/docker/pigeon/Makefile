IMAGE_REPO := "nexus.cambricon.com/jarvis-auto-docker/jarvis-dev"
IMAGE_VER := "0.0.1-pigeon"

.PHONY: pigeon

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   make pigeon           - build pigeon images"
	@echo "   make pull             - pull images"
	@echo "   make clean            - remove images"
	@echo ""

pigeon:
	@DOCKER_BUILDKIT=1 \
	docker build --network=host --tag=${IMAGE_REPO}:${IMAGE_VER} .

pull:
	@docker pull ${IMAGE_REPO}:latest

upload:
	@docker tag ${IMAGE_REPO}:${IMAGE_VER} ${IMAGE_REPO}:latest
	@docker push ${IMAGE_REPO}:${IMAGE_VER}
	@docker push ${IMAGE_REPO}:latest

clean:
	@docker rmi -f ${IMAGE_REPO}:${IMAGE_VER}
