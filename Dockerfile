# Базовий образ
FROM quay.io/projectquay/golang:1.20
# Директорія в середині контейнера
WORKDIR /app
# Копіювання бінарних файлів до контейнеру
COPY myapp_linux ./myapp_linux
COPY myapp_arm ./myapp_arm
COPY myapp_macos ./myapp_macos
COPY myapp_windows.exe ./myapp_windows.exe
# Определение переменных среды для сборки приложения в контейнере
ENV GOOS=linux \
    GOARCH=amd64
# Збираємо додаток до контейнеру
RUN go build -o myapp
# Стартуємо додаток при старті контейнера
CMD ["./myapp"]