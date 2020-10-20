
CACHE_FROM := $(if $(AWS_REGISTRY_IMAGE),--cache-from ${AWS_REGISTRY_IMAGE}:latest,)
BASE_IMAGE_NAME := s3d-base-ubuntu
BASE_IMAGE := $(if $(AWS_REGISTRY),${AWS_REGISTRY}/${BASE_IMAGE_NAME},${BASE_IMAGE_NAME})

s3d-cgal-ubuntu.image: %.image: %.dockerfile FORCE
	docker build -f $< -t $(basename $@) ${CACHE_FROM} --build-arg BUILDKIT_INLINE_CACHE=1 .

s3d-cgal-ubuntu.dockerfile: %: %.in
	sed '/^FROM/s|BASE_IMAGE|${BASE_IMAGE}|' $< > $@

.PHONY: FORCE
