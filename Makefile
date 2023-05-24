# Змінні для імені вихідного файлу і тегу образу Docker
BINARY_NAME=myapp
IMAGE_TAG=myapp:latetast
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
	rm -f $(BINARY_NAME)?
	docker rmi $(IMAGE_TAG)
# Створення Docker-образу
docker-build:
	docker build -t $(IMAGE_TAG) -f Dockerfile .