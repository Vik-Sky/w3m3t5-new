# Змінні для імені вихідного файлу і тегу образу Docker
BINARY_NAME := myapp
IMAGE_TAG := myapp:latest
# Виявлення середовища
GOOS=linux
GOARCH=amd64
# Основна ціль, яка буде виконуватися за замовчуванням
all: linux
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
	docker rmi $(IMAGE_TAG)
# Створення Docker-образу
build:
#	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o $(BINARY_NAME)
	docker build -t $(IMAGE_TAG) -f Dockerfile .
#	docker run $(IMAGE_TAG)