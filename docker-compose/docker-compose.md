Docker Compose is one of the most practical tools in container-based development because it lets you run **multi-container applications using a single YAML file**.

Below is a complete, Git-ready documentation style guide for understanding, using, installing, and designing with Docker Compose.

---

# 🐳 Docker Compose – Complete Guide

## 📌 What is Docker Compose?

Docker Compose is a tool used to define and run **multi-container Docker applications** using a simple YAML file (`docker-compose.yml`).

Instead of running multiple `docker run` commands, you define everything in one file:

* App containers
* Databases
* Networks
* Volumes
* Environment variables

Then you start everything using a single command:

```bash
docker compose up
```

---

# 🧠 Why Docker Compose?

Without Compose:

* You manually run multiple containers
* Manage networking manually
* Hard to maintain setups
* Not reproducible

With Compose:

* One YAML file = full stack
* Easy onboarding
* Repeatable environments
* Ideal for Dev/Test/CI

---

# ⚙️ Docker Compose Architecture

## 🏗️ Core Components

* **Services** → Containers (app, DB, cache)
* **Networks** → Communication layer
* **Volumes** → Persistent storage
* **Configs/Env** → Runtime configuration

---

## 📊 Flow Diagram (How it works)

```
        docker-compose.yml
                │
                ▼
        Docker Compose CLI
                │
                ▼
        Docker Engine (Docker Daemon)
        ┌────────┴────────┐
        ▼                 ▼
   App Container     DB Container
        │                 │
        └─────Network─────┘
                │
            Shared Communication
```

### 🔄 Execution Flow

```text
docker compose up
        │
        ▼
Reads docker-compose.yml
        │
        ▼
Creates Network
        │
        ├── Builds / pulls images
        │
        ├── Starts containers
        │
        └── Connects services via DNS
```

---

# 📄 Basic docker-compose.yml Example

### 🧪 Example: Web App + MySQL

```yaml
version: "3.9"

services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    depends_on:
      - db

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: appdb
```

---

# 🚀 How to Use Docker Compose

## 1️⃣ Create file

```bash
touch docker-compose.yml
```

## 2️⃣ Validate file

```bash
docker compose config
```

## 3️⃣ Start services

```bash
docker compose up
```

## 4️⃣ Run in background

```bash
docker compose up -d
```

## 5️⃣ Stop services

```bash
docker compose down
```

## 6️⃣ View logs

```bash
docker compose logs
```

## 7️⃣ List running containers

```bash
docker compose ps
```

---

# 🔧 Installation Guide

## 🐧 Linux (Ubuntu/Debian)

Docker Compose is included in modern Docker versions:

```bash
sudo apt update
sudo apt install docker.io -y
```

Check:

```bash
docker compose version
```

---

## 🪟 Windows / Mac

Install **Docker Desktop**

* Compose is included by default
* Enable WSL2 (Windows)

---

# 🧱 Key Docker Compose Concepts

## 1. Services

Each container is a service.

```yaml
services:
  app:
    image: node
```

---

## 2. Ports Mapping

```yaml
ports:
  - "8080:80"
```

Host → Container mapping

---

## 3. Volumes (Persistence)

```yaml
volumes:
  - db_data:/var/lib/mysql
```

---

## 4. Environment Variables

```yaml
environment:
  NODE_ENV: production
```

---

## 5. Depends On

Controls startup order:

```yaml
depends_on:
  - db
```

---

# 🔄 Docker Compose Lifecycle

```
Write YAML
   ↓
Validate config
   ↓
Build/Fetch images
   ↓
Create network
   ↓
Start containers
   ↓
Attach logs (optional)
   ↓
Stop & remove (down)
```

---

# 🧪 Real-World Example Stack

### 🧱 Full Stack App

* Frontend (React)
* Backend (Node.js)
* Database (PostgreSQL)
* Cache (Redis)

```yaml
version: "3.9"

services:
  frontend:
    image: nginx
    ports:
      - "3000:80"

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: pass

  redis:
    image: redis:alpine
```

## Recommended structure

```
project/
│
├── docker-compose.yml
├── backend/
│   └── Dockerfile
├── frontend/
│   └── Dockerfile
└── .env
```

---

## 🧱 Real Example: Web App + DB

### 📄 docker-compose.yml

```yaml
version: "3.9"

services:

  web:
    image: nginx:latest
    container_name: web_server
    ports:
      - "8080:80"
    depends_on:
      - app

  app:
    image: node:18
    container_name: node_app
    working_dir: /app
    volumes:
      - .:/app
    command: node index.js
    ports:
      - "3000:3000"
    depends_on:
      - db

  db:
    image: mysql:8
    container_name: mysql_db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: appdb
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

---

## 🧭 Architecture Diagram

```text
            ┌──────────────┐
            │   Browser    │
            └──────┬───────┘
                   │
                   ▼
            ┌──────────────┐
            │  NGINX (web) │
            └──────┬───────┘
                   │
        ┌──────────┴──────────┐
        ▼                     ▼
┌──────────────┐     ┌──────────────┐
│ Node.js App  │────▶│ MySQL DB     │
└──────────────┘     └──────────────┘
```

---

## 🔌 Networking in Docker Compose

* All services are on **same default network**
* Each service can be accessed by name:

```bash
http://app:3000
mysql -h db -u root -p
```

👉 No need for IP addresses

---

## 💾 Volumes (Data Persistence)

### Example:

```yaml
volumes:
  db_data:
```

* Stores DB data permanently
* Even if container is removed, data remains

---

## 🔁 Important Commands

| Command                        | Description                |
| ------------------------------ | -------------------------- |
| `docker compose up`            | Start all services         |
| `docker compose up -d`         | Start in background        |
| `docker compose down`          | Stop and remove containers |
| `docker compose ps`            | List running services      |
| `docker compose logs`          | View logs                  |
| `docker compose build`         | Build images               |
| `docker compose exec app bash` | Enter container            |

---

## 🧪 Environment Variables Example

```yaml
services:
  app:
    image: node:18
    environment:
      NODE_ENV: production
      API_KEY: abc123
```

Or use `.env` file:

```bash
NODE_ENV=production
API_KEY=abc123
```

---

## 🔄 depends_on (Startup Order)

```yaml
services:
  app:
    depends_on:
      - db
```

👉 Means:

* DB starts first
* App starts after DB

⚠️ Note: It does NOT wait for DB to be “ready”, only started.

---

## 🧰 Build Custom Image

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
```

---

# 📌 Docker Compose vs Docker CLI

| Feature         | Docker CLI       | Docker Compose         |
| --------------- | ---------------- | ---------------------- |
| Multi-container | Hard             | Easy                   |
| Configuration   | Commands         | YAML file              |
| Networking      | Manual           | Auto                   |
| Reusability     | Low              | High                   |
| Best use        | Single container | Full application stack |

---

## 🔐 Best Practices

* Use `.env` file
* Use `.env` files for secrets
* Avoid hardcoding passwords
* Use named volumes
* Use named volumes for DB persistence
* Use service names for networking (not IPs)
* Use version control for compose files
* Keep compose file modular
* Separate dev/prod compose files:

```bash
docker-compose.dev.yml
docker-compose.prod.yml
```

---

# 📈 Advanced Features

## 1. Build from Dockerfile

```yaml
build: .
```

## 2. Scaling services

```bash
docker compose up --scale app=3
```

## 3. Profiles (selective services)

```yaml
profiles:
  - dev
```

---

# 🧠 Mental Model

Think of Docker Compose like:

> “A blueprint for running a full application stack with multiple containers that work together automatically.”

---

# 📘 Git Documentation Tip

You can structure your repo like:

```
docker-compose-guide/
│
├── README.md
├── examples/
│   ├── simple-compose.yml
│   ├── fullstack.yml
├── diagrams/
│   └── architecture.png
```

