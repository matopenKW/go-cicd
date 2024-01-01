
run:
	go run ./cmd/http/main.go

docker-build:
	docker build -f ./docker/Dockerfile -t go-cicd .
