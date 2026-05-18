# 🐳 Docker — Complete Notes for Learning & Understanding

> **Goal:** Understand Docker simply, deeply, and practically — with diagrams, examples, commands, and integrations. GitHub `.md` ready.

---

## 📌 Table of Contents

1. [What is Docker?](#1-what-is-docker)
2. [Why Docker? (The Problem it Solves)](#2-why-docker-the-problem-it-solves)
3. [Core Concepts](#3-core-concepts)
4. [Docker Architecture](#4-docker-architecture)
5. [Docker Workflow (Flowchart)](#5-docker-workflow-flowchart)
6. [Installation](#6-installation)
7. [Essential Commands (Cheat Sheet)](#7-essential-commands-cheat-sheet)
8. [Dockerfile — Build Your Own Image](#8-dockerfile--build-your-own-image)
9. [Docker Volumes (Persistent Data)](#9-docker-volumes-persistent-data)
10. [Docker Networking](#10-docker-networking)
11. [Docker Compose](#11-docker-compose)
12. [Real-World Example: Node.js App](#12-real-world-example-nodejs-app)
13. [Docker Integrations](#13-docker-integrations)
14. [Docker vs VM — Visual Comparison](#14-docker-vs-vm--visual-comparison)
15. [Best Practices](#15-best-practices)
16. [Quick Reference Card](#16-quick-reference-card)

---

## 1. What is Docker?

**Docker** is a tool that packages your app + everything it needs (code, runtime, libraries, config) into a **container** — so it runs the same everywhere.

> 💡 Think of it like a **lunchbox** — you pack everything the meal needs. Wherever you open it, the meal is exactly the same.

---

## 2. Why Docker? (The Problem it Solves)

### 😩 Before Docker

```
Developer's laptop:  "It works on my machine!" ✅
Staging server:      Crashes due to different Node version ❌
Production server:   Different OS, missing library ❌
```

### 😊 After Docker

```
Developer's laptop:  Runs in container ✅
Staging server:      Same container ✅
Production server:   Same container ✅
```

**One container = same environment everywhere.**

---

## 3. Core Concepts

| Concept | Simple Explanation | Analogy |
|---|---|---|
| **Image** | A blueprint/snapshot of the app | Recipe 📄 |
| **Container** | A running instance of an image | Cooked dish 🍛 |
| **Dockerfile** | Instructions to build an image | Recipe steps 📝 |
| **Docker Hub** | Public registry to store/share images | App Store 🏪 |
| **Volume** | Persistent storage for containers | USB drive 💾 |
| **Network** | Communication between containers | Phone line 📞 |
| **Compose** | Run multiple containers together | Orchestra 🎼 |

---

## 4. Docker Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         YOUR MACHINE                        │
│                                                             │
│   ┌─────────────────────────────────────────────────────┐   │
│   │                   DOCKER ENGINE                     │   │
│   │                                                     │   │
│   │   ┌──────────────┐     ┌──────────────┐            │   │
│   │   │  Container 1  │     │  Container 2  │           │   │
│   │   │  ┌─────────┐ │     │  ┌─────────┐ │           │   │
│   │   │  │  App    │ │     │  │  App    │ │           │   │
│   │   │  │ (Node)  │ │     │  │(Python) │ │           │   │
│   │   │  ├─────────┤ │     │  ├─────────┤ │           │   │
│   │   │  │  Libs   │ │     │  │  Libs   │ │           │   │
│   │   │  ├─────────┤ │     │  ├─────────┤ │           │   │
│   │   │  │  Deps   │ │     │  │  Deps   │ │           │   │
│   │   │  └─────────┘ │     │  └─────────┘ │           │   │
│   │   └──────────────┘     └──────────────┘            │   │
│   │                                                     │   │
│   │              ┌───────────────┐                      │   │
│   │              │  Docker Daemon│  ← manages all       │   │
│   │              └───────────────┘                      │   │
│   └─────────────────────────────────────────────────────┘   │
│                                                             │
│              HOST OS (Linux / macOS / Windows)              │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
              ┌───────────────────────┐
              │      Docker Hub       │  (Remote Registry)
              │  nginx, node, mysql…  │
              └───────────────────────┘
```

### Key Components

| Component | Role |
|---|---|
| **Docker Client** | CLI tool — you type commands here (`docker run`, `docker build`) |
| **Docker Daemon** | Background service that does the actual work |
| **Docker Registry** | Stores images (Docker Hub, AWS ECR, GitHub Packages) |
| **containerd** | Low-level runtime that actually runs containers |

---

## 5. Docker Workflow (Flowchart)

```
  Write Code
      │
      ▼
  Create Dockerfile          ← Instructions to build your image
      │
      ▼
  docker build -t myapp .    ← Builds an image from Dockerfile
      │
      ▼
  Image Created (local)
      │
      ├──────────────────────────────────────────────────┐
      ▼                                                  ▼
  docker run myapp        (run locally)     docker push myapp   (share to registry)
      │                                                  │
      ▼                                                  ▼
  Container Running 🟢                        Others pull & run
      │
      ├────────────────────────────────────┐
      ▼                                    ▼
  docker stop myapp               docker logs myapp
  docker rm myapp                 docker exec -it myapp bash
```

---

## 6. Installation

### macOS / Windows
Download **Docker Desktop** → [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

### Linux (Ubuntu)

```bash
# Update package list
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (avoid sudo every time)
sudo usermod -aG docker $USER

# Verify installation
docker --version
# Output: Docker version 24.x.x, build ...
```

---

## 7. Essential Commands (Cheat Sheet)

### 🖼️ Images

```bash
# Pull an image from Docker Hub
docker pull nginx

# List all local images
docker images

# Build image from Dockerfile in current directory
docker build -t myapp:1.0 .

# Remove an image
docker rmi myapp:1.0

# Tag an image
docker tag myapp:1.0 username/myapp:1.0
```

### 📦 Containers

```bash
# Run a container (pulls if not local)
docker run nginx

# Run in background (detached mode)
docker run -d nginx

# Run with a name
docker run -d --name my-nginx nginx

# Run with port mapping  (host:container)
docker run -d -p 8080:80 nginx

# Run with environment variables
docker run -d -e DB_HOST=localhost myapp

# Run interactively (enter shell)
docker run -it ubuntu bash

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop my-nginx

# Start a stopped container
docker start my-nginx

# Remove a container
docker rm my-nginx

# Force remove running container
docker rm -f my-nginx

# View logs
docker logs my-nginx
docker logs -f my-nginx    # Follow/stream logs
```

### 🔍 Inspect & Debug

```bash
# Enter a running container
docker exec -it my-nginx bash

# Inspect container details (JSON)
docker inspect my-nginx

# View resource usage
docker stats

# View container processes
docker top my-nginx

# Copy files to/from container
docker cp file.txt my-nginx:/app/file.txt
docker cp my-nginx:/app/log.txt ./log.txt
```

### 🧹 Cleanup

```bash
# Remove all stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove everything unused (containers, images, volumes, networks)
docker system prune -a
```

---

## 8. Dockerfile — Build Your Own Image

A `Dockerfile` is a text file with instructions to build an image.

### Basic Structure

```dockerfile
# Base image to start from
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Command to run when container starts
CMD ["node", "server.js"]
```

### Dockerfile Instructions Explained

| Instruction | What it does | Example |
|---|---|---|
| `FROM` | Base image to build on | `FROM ubuntu:22.04` |
| `WORKDIR` | Set working directory | `WORKDIR /app` |
| `COPY` | Copy files from host to image | `COPY . .` |
| `ADD` | Like COPY but supports URLs & tar | `ADD app.tar.gz /app` |
| `RUN` | Execute command during build | `RUN npm install` |
| `CMD` | Default command when container starts | `CMD ["node", "app.js"]` |
| `ENTRYPOINT` | Container's main process (not easily overridden) | `ENTRYPOINT ["python"]` |
| `ENV` | Set environment variables | `ENV NODE_ENV=production` |
| `EXPOSE` | Document which port app uses | `EXPOSE 8080` |
| `ARG` | Build-time variable | `ARG VERSION=1.0` |
| `VOLUME` | Mount point for volumes | `VOLUME /data` |
| `USER` | Set user for subsequent commands | `USER node` |

### 📦 Build Layer Caching

```
Each instruction creates a layer.
If a layer hasn't changed, Docker reuses the cached version → faster builds.

Layer 1: FROM node:18          ← cached ✅
Layer 2: WORKDIR /app          ← cached ✅
Layer 3: COPY package*.json .  ← cached ✅ (if package.json unchanged)
Layer 4: RUN npm install        ← cached ✅ (expensive, good to cache!)
Layer 5: COPY . .               ← rebuilt (code changed)
Layer 6: CMD ["node", "app.js"] ← rebuilt
```

> 💡 **Tip:** Copy `package.json` and install deps BEFORE copying your source code — so npm install is cached unless dependencies change.

### .dockerignore

Like `.gitignore` — prevents unnecessary files from being copied into the image:

```
node_modules
.git
.env
*.log
dist
coverage
```

---

## 9. Docker Volumes (Persistent Data)

By default, container data is lost when it stops. **Volumes** solve this.

```
Without Volumes:
Container dies → All data gone 💀

With Volumes:
Container dies → Data lives on disk ✅
New container mounts same volume → Data restored ✅
```

### Types of Storage

```
┌─────────────────────────────────────────┐
│              HOST MACHINE               │
│                                         │
│  /var/lib/docker/volumes/mydata  ←──────┼─── Named Volume
│                                         │
│  /home/user/myproject            ←──────┼─── Bind Mount
│                                         │
│           RAM                    ←──────┼─── tmpfs (temp, fast)
└─────────────────────────────────────────┘
```

### Volume Commands

```bash
# Create a named volume
docker volume create mydata

# List volumes
docker volume ls

# Run container with volume
docker run -d -v mydata:/app/data myapp

# Bind mount (map host folder to container folder)
docker run -d -v /home/user/app:/app myapp

# Shorthand with $(pwd) for current directory
docker run -d -v $(pwd):/app myapp

# Inspect a volume
docker volume inspect mydata

# Remove a volume
docker volume rm mydata
```

---

## 10. Docker Networking

Containers can talk to each other through networks.

### Network Types

| Type | Use Case |
|---|---|
| `bridge` | Default. Containers on same host communicate |
| `host` | Container shares host's network (Linux only) |
| `none` | No networking |
| `overlay` | Multi-host networking (Docker Swarm) |

### Network Commands

```bash
# List networks
docker network ls

# Create a custom network
docker network create mynet

# Run container on a specific network
docker run -d --name app1 --network mynet myapp
docker run -d --name app2 --network mynet mydb

# app1 can reach app2 using its name: http://app2:5432
# No IP needed! Docker has built-in DNS.

# Inspect network
docker network inspect mynet

# Connect a running container to a network
docker network connect mynet my-nginx

# Remove a network
docker network rm mynet
```

### Container Communication Diagram

```
┌─────────────────────────────────────────────────────┐
│                  Custom Network: mynet               │
│                                                     │
│   ┌─────────────┐          ┌─────────────┐          │
│   │   web-app   │─────────▶│  postgres   │          │
│   │  (port 3000)│          │  (port 5432)│          │
│   └─────────────┘          └─────────────┘          │
│          │                                           │
└──────────┼───────────────────────────────────────────┘
           │ port 8080:3000
           ▼
        Browser
     localhost:8080
```

---

## 11. Docker Compose

Run **multiple containers** together with one file and one command.

### docker-compose.yml

```yaml
version: '3.8'

services:
  # Web application
  web:
    build: .                        # Build from local Dockerfile
    ports:
      - "3000:3000"                 # host:container
    environment:
      - DB_HOST=db
      - DB_PORT=5432
    depends_on:
      - db                          # Start db first
    volumes:
      - ./app:/app                  # Bind mount for dev
    networks:
      - mynet

  # Database
  db:
    image: postgres:15              # Pull from Docker Hub
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: myapp
    volumes:
      - pgdata:/var/lib/postgresql/data   # Named volume for persistence
    networks:
      - mynet

  # Cache
  redis:
    image: redis:alpine
    networks:
      - mynet

volumes:
  pgdata:                           # Declare named volume

networks:
  mynet:                            # Declare custom network
```

### Docker Compose Commands

```bash
# Start all services (detached)
docker compose up -d

# Start and rebuild images
docker compose up -d --build

# View running services
docker compose ps

# View logs (all services)
docker compose logs

# View logs for one service
docker compose logs web

# Stop all services
docker compose down

# Stop and remove volumes (data!)
docker compose down -v

# Scale a service (run 3 instances of web)
docker compose up -d --scale web=3

# Run a command in a service container
docker compose exec web bash

# Restart one service
docker compose restart web
```

---

## 12. Real-World Example: Node.js App

Let's containerize a simple Node.js + MongoDB app.

### Project Structure

```
myapp/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── package.json
└── server.js
```

### server.js

```javascript
const express = require('express');
const mongoose = require('mongoose');

const app = express();
app.use(express.json());

// Connect to MongoDB (uses service name 'mongo' as hostname)
mongoose.connect(process.env.MONGO_URL || 'mongodb://mongo:27017/myapp');

app.get('/', (req, res) => res.send('Hello from Docker! 🐳'));

app.listen(3000, () => console.log('Server running on port 3000'));
```

### Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 3000

USER node

CMD ["node", "server.js"]
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - MONGO_URL=mongodb://mongo:27017/myapp
    depends_on:
      - mongo
    restart: unless-stopped

  mongo:
    image: mongo:6
    volumes:
      - mongodata:/data/db
    restart: unless-stopped

volumes:
  mongodata:
```

### Run It

```bash
docker compose up -d

# Test it
curl http://localhost:3000
# Output: Hello from Docker! 🐳

# Check logs
docker compose logs app
```

---

## 13. Docker Integrations

### 🔁 CI/CD — GitHub Actions

```yaml
# .github/workflows/docker.yml
name: Build and Push Docker Image

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and Push
        uses: docker/build-push-action@v4
        with:
          push: true
          tags: username/myapp:latest
```

### ☁️ Cloud Integrations

| Platform | Service | Command |
|---|---|---|
| **AWS** | ECS / ECR | `aws ecr get-login-password \| docker login ...` |
| **Google Cloud** | Cloud Run / GCR | `gcloud auth configure-docker` |
| **Azure** | ACI / ACR | `az acr login --name myregistry` |
| **DigitalOcean** | App Platform | Push to DOCR registry |

### ☸️ Kubernetes (K8s)

Docker images are used directly in Kubernetes:

```yaml
# k8s-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  template:
    spec:
      containers:
        - name: myapp
          image: username/myapp:latest   # Docker image!
          ports:
            - containerPort: 3000
```

### 🧪 Testing

```bash
# Run tests inside container (isolated environment)
docker run --rm myapp npm test

# Run specific test suite
docker compose run --rm app npm run test:unit
```

### 🛠️ Development with VS Code

Install the **Docker extension** in VS Code:
- View containers, images, logs in sidebar
- Right-click to open shell in container
- Attach VS Code to a running container

```json
// .devcontainer/devcontainer.json
{
  "name": "My App Dev",
  "dockerComposeFile": "../docker-compose.yml",
  "service": "app",
  "workspaceFolder": "/app"
}
```

---

## 14. Docker vs VM — Visual Comparison

```
┌─────────────────────────────┐    ┌─────────────────────────────┐
│        VIRTUAL MACHINE      │    │           DOCKER             │
│                             │    │                             │
│  ┌────────┐  ┌────────┐    │    │  ┌────────┐  ┌────────┐    │
│  │ App A  │  │ App B  │    │    │  │Container│  │Container│   │
│  ├────────┤  ├────────┤    │    │  │   A    │  │   B    │   │
│  │ Libs   │  │ Libs   │    │    │  ├────────┤  ├────────┤   │
│  ├────────┤  ├────────┤    │    │  │ Libs   │  │ Libs   │   │
│  │ Guest  │  │ Guest  │    │    │  └────────┘  └────────┘   │
│  │  OS    │  │  OS    │    │    │                             │
│  ├────────┴──┴────────┤    │    │  ┌───────────────────────┐  │
│  │    Hypervisor      │    │    │  │    Docker Engine       │  │
│  ├────────────────────┤    │    │  ├───────────────────────┤  │
│  │      Host OS       │    │    │  │       Host OS         │  │
│  ├────────────────────┤    │    │  ├───────────────────────┤  │
│  │      Hardware      │    │    │  │       Hardware        │  │
│  └────────────────────┘    │    │  └───────────────────────┘  │
└─────────────────────────────┘    └─────────────────────────────┘

  Size: 1–20 GB per VM                Size: 10–500 MB per container
  Boot: Minutes                        Boot: Seconds (or milliseconds)
  Isolation: Full OS isolation         Isolation: Process-level isolation
  Overhead: High                       Overhead: Very low
```

| Feature | VM | Docker |
|---|---|---|
| Startup Time | Minutes | Seconds |
| Size | GBs | MBs |
| Performance | Lower | Near-native |
| Isolation | Strong (full OS) | Process-level |
| Portability | Limited | Excellent |
| Use Case | Full OS needed | App packaging |

---

## 15. Best Practices

### 🏗️ Dockerfile

```dockerfile
# ✅ Use specific tags (not 'latest' in production)
FROM node:18.19-alpine

# ✅ Minimize layers — combine RUN commands
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# ✅ Use non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# ✅ Use multi-stage builds to reduce image size
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm run build

FROM node:18-alpine AS production   # ← fresh small image
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/server.js"]
```

### 🔐 Security

```bash
# Scan image for vulnerabilities
docker scout cves myapp:latest

# Never store secrets in Dockerfile
# ❌ BAD
ENV DB_PASSWORD=mysecret

# ✅ GOOD — use environment variables at runtime
docker run -e DB_PASSWORD=mysecret myapp

# Or use Docker Secrets (in Swarm)
docker secret create db_password password.txt
```

### 📏 General Rules

- ✅ One process per container
- ✅ Keep images small (use Alpine base)
- ✅ Use `.dockerignore` always
- ✅ Tag images with versions (`myapp:1.2.3`)
- ✅ Use health checks

```dockerfile
# Health check in Dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1
```

---

## 16. Quick Reference Card

```
┌──────────────────────────────────────────────────────────┐
│                  DOCKER QUICK REFERENCE                  │
├──────────────────┬───────────────────────────────────────┤
│ IMAGES           │ CONTAINERS                            │
│ docker pull      │ docker run -d -p 8080:80 nginx        │
│ docker images    │ docker ps / docker ps -a              │
│ docker build -t  │ docker stop / start / rm              │
│ docker push      │ docker exec -it <name> bash           │
│ docker rmi       │ docker logs -f <name>                 │
├──────────────────┼───────────────────────────────────────┤
│ VOLUMES          │ NETWORKS                              │
│ docker volume ls │ docker network ls                     │
│ -v name:/path    │ docker network create mynet           │
│ -v $(pwd):/app   │ --network mynet                       │
├──────────────────┼───────────────────────────────────────┤
│ COMPOSE          │ CLEANUP                               │
│ docker compose up -d         │ docker system prune -a   │
│ docker compose down          │ docker container prune   │
│ docker compose logs          │ docker image prune       │
│ docker compose exec web bash │ docker volume prune      │
└──────────────────────────────┴──────────────────────────┘
```

---

## 🎓 Learning Path

```
Beginner                  Intermediate               Advanced
    │                          │                         │
    ▼                          ▼                         ▼
docker run              Dockerfile               Docker Swarm
docker ps               Multi-stage builds       Kubernetes
docker pull/push        Docker Compose           CI/CD pipelines
Basic commands          Volumes & Networks       Security hardening
                        Environment vars         Monitoring (Prometheus)
```

---

## 📚 Resources

| Resource | Link |
|---|---|
| Official Docs | [docs.docker.com](https://docs.docker.com) |
| Docker Hub | [hub.docker.com](https://hub.docker.com) |
| Play with Docker | [labs.play-with-docker.com](https://labs.play-with-docker.com) |
| Docker Curriculum | [docker-curriculum.com](https://docker-curriculum.com) |

---

> **Made for learning. Copy, fork, and share freely.** 🐳  
> *"Build once. Run anywhere."*