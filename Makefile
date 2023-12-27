echo:	
	docker-compose run js echo Hello
	docker-compose run r echo World
	
build: build-docker build-js build-R
build-docker:
	docker-compose build
build-js: 
	docker-compose run js yarn run webpack
build-R:
	docker-compose run r R CMD build .
	
# bash -c is needed becasue docker exec does not resolve wildcard (*)
# $$ escapes $ in make
test:
	docker-compose run r bash -c 'R CMD check $$(ls shinyjsonschemaform*.tar.gz)'