# https://zenn.dev/yyu/articles/3f900eaa2aa860

TAG=hkim0331/racket:latest

all:manifest

build: amd64 arm64

amd64:
	docker buildx build --platform linux/$@ --push -t ${TAG}-$@ .

arm64:
	docker buildx build --platform linux/$@ --push -t ${TAG}-$@ .

manifest: build
	docker manifest create --amend ${TAG} ${TAG}-amd64 ${TAG}-arm64
	docker manifest push ${TAG}

