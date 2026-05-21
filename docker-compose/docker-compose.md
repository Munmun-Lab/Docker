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

# 🧭 Design Pattern (Best Practice)

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

## 🔐 Best Practices

* Use `.env` files for secrets
* Avoid hardcoding passwords
* Use named volumes for DB persistence
* Use service names for networking (not IPs)
* Keep compose file modular

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

