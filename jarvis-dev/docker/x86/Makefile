IMAGE_REPO := "nexus.cambricon.com/jarvis-auto-docker/jarvis-dev"
BASE_VER := "base-noetic-cuda11.1.1-trt8.0.1"
DEVEL_VER := "0.1.5"

.PHONY: base devel

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   make base             - build base images"
	@echo "   make devel            - build devel images"
	@echo "   make pull             - pull images"
	@echo "   make clean            - remove images"
	@echo ""

base:
	@DOCKER_BUILDKIT=1 \
	docker build \
		--tag=${IMAGE_REPO}:${BASE_VER} \
		base

devel:
	@DOCKER_BUILDKIT=1 \
	docker build \
		--no-cache \
		--tag=${IMAGE_REPO}:${DEVEL_VER} \
		devel

pull:
	@docker pull ${IMAGE_REPO}:latest

upload:
	@docker tag ${IMAGE_REPO}:${DEVEL_VER} ${IMAGE_REPO}:latest
	@docker push ${IMAGE_REPO}:${DEVEL_VER}
	@docker push ${IMAGE_REPO}:latest

clean:
	@docker rmi -f ${IMAGE_REPO}:${DEVEL_VER}
