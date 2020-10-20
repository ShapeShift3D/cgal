PROJECT_NAME := cgal
CACHE_FROM := $(if $(AWS_REGISTRY_IMAGE),--cache-from ${AWS_REGISTRY_IMAGE}:latest,)

AWS_REGISTRY_SUBSTITUTION := $(if $(AWS_REGISTRY),${AWS_REGISTRY}/,)

s3d-${PROJECT_NAME}-ubuntu.image: %.image: %.dockerfile FORCE
	docker build -f $< -t $(basename $@) ${CACHE_FROM} --build-arg BUILDKIT_INLINE_CACHE=1 .

s3d-${PROJECT_NAME}-ubuntu.dockerfile: %: %.in
	sed 's|\$${AWS_REGISTRY}/|${AWS_REGISTRY_SUBSTITUTION}|' $< > $@

.PHONY: FORCE
