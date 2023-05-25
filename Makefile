# Змінні для імені вихідного файлу і тегу образу Docker
BINARY_NAME := myapp
IMAGE_TAG := myapp:latest
# Виявлення середовища
GOOS=linux
GOARCH=amd64
# Основна ціль, яка буде виконуватися за замовчуванням
all: linux arm macos windows
# Збірка коду для Linux
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o $(BINARY_NAME)
# Збірка коду для ARM
arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -v -o $(BINARY_NAME)
# Збірка коду для macOS
macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o $(BINARY_NAME)
# Збірка коду для Windows
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o $(BINARY_NAME)
# Очищення згенерованих файлів / Видалення Docker-образу
clean:
	rm -f $(BINARY_NAME)
	docker ps -a
	docker images
	docker stop $$(docker ps -q -n 1)
	docker rm $$(docker ps -q -n 1)
	docker rmi $(IMAGE_TAG)
	docker ps -a
	docker images
# Створення Docker-образу
build:
	docker build -t $(IMAGE_TAG) -f Dockerfile .
	docker run $(IMAGE_TAG)