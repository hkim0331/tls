# https://zenn.dev/yyu/articles/3f900eaa2aa860

TAG=hkim0331/racket:0.3

zip:
	zip -r racket.zip Dockerfile Makefile docker-compose.yml .devcontainer

security:
	security -v unlock-keychain ~/Library/Keychains/login.keychain-db

clean:
	${RM} racket.zip *~

manifest: amd64 arm64
	docker manifest create --amend ${TAG} ${TAG}-amd64 ${TAG}-arm64
	docker manifest push ${TAG}

amd64:
	docker buildx build --platform linux/$@ --push -t ${TAG}-$@ .

arm64:
	docker buildx build --platform linux/$@ --push -t ${TAG}-$@ .

