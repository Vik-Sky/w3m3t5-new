# Змінні для імені вихідного файлу і тегу образу Docker
BINARY_NAME := myapp
IMAGE_TAG := myapp:latest
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
# Виявлення середовища
TARGETOS=linux #linux darwin windows
TARGETARCH=arm64 #amd64 arm64
# Основна ціль, яка буде виконуватися за замовчуванням
all: linux
# Збірка коду для Linux
linux:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o $(BINARY_NAME)
# Збірка коду для ARM
arm:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o $(BINARY_NAME)
# Збірка коду для macOS
macos:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o $(BINARY_NAME)
# Збірка коду для Windows
windows:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o $(BINARY_NAME)
# Очищення згенерованих файлів / Видалення Docker-образу
clean:
	rm -f $(BINARY_NAME)
	docker rmi $(IMAGE_TAG)
# Створення Docker-образу
image:
	docker build -t $(BINARY_NAME) --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS} -f Dockerfile .
#	docker run $(IMAGE_TAG)
#	docker build -t $(BINARY_NAME) -f Dockerfile .