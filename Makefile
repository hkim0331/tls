all: hkim0331/racket

build: hkim0331/racket

hkim0331/racket:
	docker build -t $@ .

clean:
	cd src; make clean
	${RM} *~
