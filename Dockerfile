# Базовий образ
FROM quay.io/projectquay/golang:1.20
# Директорія в середині контейнера
WORKDIR /app
# Копіювання бінарних файлів до контейнеру
COPY . .
# Збираємо додаток до контейнеру
RUN go build -o myapp
# Стартуємо додаток при старті контейнера
ENTRYPOINT ["./myapp", "start"]