#################
## Production ##
################
start:
	docker container start mongo mongo-express app
build:
	./boot.sh
stop:
	docker container stop app mongo-express mongo
destroy: stop
	docker network rm restless-api;
	docker container rm app mongo-express mongo;
	docker image rm node-api;

##################
## Development ##
#################
dev-start:
	docker-compose up --detach
dev-build:
	docker-compose up --detach --build;
dev-shell:
	docker-compose exec app bash
dev-stop:
	docker-compose stop
dev-destroy:
	docker-compose down --volume