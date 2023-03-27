# https://zenn.dev/yyu/articles/3f900eaa2aa860

TAG=hkim0331/racket:latest

all:
	@echo '* make build'
	@echo '* make amd64'
	@echo '* make arm64'
	@echo '* make test-run'
	@echo '* make clean'

build: amd arm

amd64:
	docker buildx build --platform linux/amd64 --push -t ${TAG}-$@ .

arm64:
	docker buildx build --platform linux/arm64 --push -t ${TAG}-$@ .

manifest:
#	pull both images on one host
#	docker pull ${TAG}-amd64
	docker manifest create ${TAG} ${TAG}-amd64 ${TAG}-arm64
	docker manifest push ${TAG}

test-bash:
	docker run -it --rm hkim0331/racket bash

clean:
#	cd src; make clean
	${RM} *~
