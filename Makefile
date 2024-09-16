
build:
	sh doom-config-snapshot.sh


db: docker-build

docker-build:
	sudo docker build -t doom-docker .


dr: docker-run

docker-run:
	# sudo docker run -it --rm doom-docker

	sudo docker run --rm -it -u $(id -u):$(id -g) \
	  -v "`pwd`":/app --workdir /app \
	  doom-docker:latest


c: clean

clean:
	rm -fr doom-snapshot/*.el
