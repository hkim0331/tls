all:
	@echo 'make build'
	@echo 'make test-run'
	@echo 'make clean'

build: hkim0331/racket

hkim0331/racket:
	docker build -t $@ .

test-run:
	docker run -it --rm hkim0331/racket bash

clean:
#	cd src; make clean
	${RM} *~
