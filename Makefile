
build:
	go build -o ./bin/go-cicd ./cmd/http/main.go

run:
	go run ./cmd/http/main.go

docker-build:
	docker build -f ./docker/Dockerfile -t go-cicd .

azure-cli:
	docker run -it mcr.microsoft.com/azure-cli
