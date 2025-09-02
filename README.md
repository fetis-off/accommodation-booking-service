# 🏨 Accommodation Booking API

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?logo=spring&logoColor=white)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![TimescaleDB](https://img.shields.io/badge/TimescaleDB-2.14-orange?logo=timescale&logoColor=white)](https://www.timescale.com/)
[![Flyway](https://img.shields.io/badge/Flyway-10-red?logo=flyway&logoColor=white)](https://flywaydb.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker&logoColor=white)](https://www.docker.com/)

> Spring Boot–based project developed for a university Spring course by students of **IS-32**:  
**[Oleksandr Fetisov](https://t.me/fetis_off),  [Dmytro Shlikhanov](https://t.me/exc3pt1ontg), [Ihor Panchenko](https://t.me/f3ops3), [Oleksandr Zhovmir](https://t.me/hahazhzh), [Maksym Zaritskiy](https://t.me/Zaritskiy_M)**

---

## 📋 Features
- ⚡ **Spring Boot** application with REST API
- 🗄 **TimescaleDB (PostgreSQL 16)** as persistence layer
- 🔄 **Flyway** database migration support
- 🐳 **Docker Compose** orchestration with health checks and profiles

---

## 📦 Components Overview

| Service       | Description | Ports | Notes |
|---------------|-------------|-------|-------|
| **database**  | TimescaleDB (PostgreSQL) | `5432:5432` | Persistent volume `dbdata`, health check enabled |
| **migrator**  | Flyway migrations runner | – | One-shot run with `migrate` profile |
| **application** | Spring Boot REST API | `8080:8080` | Built from local `Dockerfile`, Flyway auto-migrations disabled |

---

## 🛠 Prerequisites
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)

---

## ⚙️ Setup & Usage

### 1️⃣ Ensure the database is running
```shell
docker compose up -d database
```
Wait until health check reports healthy.

### 2️⃣ Apply database migrations
Run Flyway migrations manually (one-shot runner):
```shell
docker compose --profile migrate run --rm migrator
```

### 3️⃣ Start the application
```shell
docker compose up -d application
```
The API is now available at:
👉 http://localhost:8080

---

## 🧩 Project Structure

```text
.
├── .env
├── Dockerfile
├── docker-compose.yml
├── src
│   └── main
│       ├── java/...                   # Spring Boot source code
│       └── resources
│           └── database/migration     # Flyway SQL migrations
```

---

## 🔑 Environment Variables

Define these variables in a .env file (example below):

```properties
DATABASE_USER=booking_admin
DATABASE_PASSWORD=secret_password
DATABASE_NAME=booking_db
```

---

## ✅ Health Monitoring

**Database:** checked via
```shell
pg_isready -U $POSTGRES_USER -d $POSTGRES_DB -h 127.0.0.1
```

Application: exposes Actuator endpoints:
- `GET /actuator/health`
- `GET /actuator/info`

---

## 📖 Notes

- Migrations **must be run before** starting the app.
- Auto-migrations are disabled (`SPRING_FLYWAY_ENABLED=false`).
- Ensure ports **5432** and **8080** are **available** on host.