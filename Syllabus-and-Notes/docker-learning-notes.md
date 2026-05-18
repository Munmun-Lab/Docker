# 🐳 Docker — Complete Learning Notes

> Everything you need to understand Docker, simply explained.

---

## Table of Contents

1. [What is Docker?](#1-what-is-docker)
2. [Core Concepts](#2-core-concepts)
3. [Docker Architecture](#3-docker-architecture)
4. [Writing a Dockerfile](#4-writing-a-dockerfile)
5. [Essential Commands](#5-essential-commands)
6. [Docker Networking](#6-docker-networking)
7. [Docker Volumes](#7-docker-volumes)
8. [Docker Compose](#8-docker-compose)
9. [Integrations](#9-integrations)
10. [Cheat Sheet](#10-cheat-sheet)

---

## 1. What is Docker?

### The Simple Analogy 🚢

Think of Docker like a **shipping container**. Before containers, ships had to deal with thousands of different box sizes. Docker does the same for software — it **packages your app + everything it needs** into one standard container that runs anywhere.

> ✅ Works on your laptop → works on server → works in cloud. **No more "it works on my machine!"**

---

### The Problem Docker Solves

| 😩 Before Docker | 😊 With Docker |
|---|---|
| App works on dev, breaks on server | Same container runs everywhere |
| Different OS versions cause bugs | Isolated environment per app |
| Setup takes hours per environment | Setup in seconds (`docker run`) |
| Dependency conflicts everywhere | No dependency conflicts |
| VMs are heavy (GBs, slow start) | Containers are light (MBs, instant) |

---

### VM vs Docker — Under the Hood

```
Virtual Machine                     Docker Container
───────────────                     ────────────────
┌─────────┬─────────┐               ┌─────────┬─────────┐
│  App A  │  App B  │               │  App A  │  App B  │
├─────────┼─────────┤               ├─────────────────────┤
│Guest OS │Guest OS │  ← heavy!     │    Docker Engine    │
├─────────┴─────────┤               ├─────────────────────┤
│    Hypervisor     │               │  Host OS  (shared)  │
├───────────────────┤               ├─────────────────────┤
│      Host OS      │               │  Physical Hardware   │
├───────────────────┤               └─────────────────────┘
│  Physical Hardware│
└───────────────────┘
```

> **Key insight:** Containers share the host OS kernel — no full OS copy needed. That's why they're fast and lightweight.

---

## 2. Core Concepts

| # | Concept | What it is | Analogy |
|---|---|---|---|
| 01 | **Image** | Read-only blueprint/template built from a Dockerfile | Recipe |
| 02 | **Container** | A running instance of an image | Pizza made from the recipe |
| 03 | **Dockerfile** | Text file with step-by-step build instructions | The recipe itself |
| 04 | **Registry** | Online store for Docker images (Docker Hub) | App Store / GitHub |
| 05 | **Volume** | Persistent storage outside the container | External hard drive |
| 06 | **Network** | Lets containers talk to each other or the world | Wi-Fi for containers |

---

### Image → Container Flow

```
STEP 1  📄 Write Dockerfile
         └─ Instructions: base image, copy files, install deps, run command

STEP 2  🔨 docker build
         └─ Docker reads Dockerfile and creates a layered image

STEP 3  🏪 docker push  (optional)
         └─ Share your image to Docker Hub or a private registry

STEP 4  ▶️  docker run
         └─ Docker creates a container from the image and starts it

STEP 5  ✅ App is Running!
         └─ Your app is live inside an isolated container
```

---

### Image Layers (How Images Work)

Each Dockerfile instruction creates one **cached layer**:

```
┌──────────────────────────────────────────┐  ← Writable (Container)
│  CMD ["python","app.py"]                 │
├──────────────────────────────────────────┤
│  COPY . /app                  (your code)│
├──────────────────────────────────────────┤
│  RUN pip install -r requirements.txt     │
├──────────────────────────────────────────┤
│  COPY requirements.txt .                 │
├──────────────────────────────────────────┤
│  RUN apt-get install python3             │
├──────────────────────────────────────────┤
│  FROM ubuntu:22.04            (base)     │
└──────────────────────────────────────────┘
```

> **Caching magic:** If a layer hasn't changed, Docker reuses the cached version. Put rarely-changing layers (like dependency installs) **before** your code copy!

---

## 3. Docker Architecture

Docker uses a **client-server** architecture:

```
┌─────────────────────────────────────────────────┐
│  👤 You (Terminal)                              │
│         ↕  REST API                             │
│  🖥️  Docker Client  (docker CLI)               │
│         ↕  Unix Socket / TCP                    │
│  ⚙️  Docker Daemon  (dockerd)                  │
│         │                                       │
│    ┌────┴──────────────────────────┐            │
│    │  📦 Containers                │            │
│    │  🖼️  Images                  │            │
│    │  🔗 Networks                  │            │
│    │  💾 Volumes                   │            │
│    └───────────────────────────────┘            │
│         ↕  push / pull                          │
│  🏪 Docker Registry  (Docker Hub / Private)     │
└─────────────────────────────────────────────────┘
```

### Key Components

| Component | What it does | Analogy |
|---|---|---|
| Docker Client | Where you type commands | TV Remote |
| Docker Daemon | Background service that builds & runs containers | The TV itself |
| Docker Images | Read-only templates | App installer file |
| Containers | Running processes created from images | Installed & running app |
| Docker Registry | Remote image storage | App Store |

---

### Container Lifecycle

```
Created ──start──▶ Running ──pause──▶ Paused
                     │
                  stop/kill
                     ↓
                  Stopped ──rm──▶ Removed
```

---

## 4. Writing a Dockerfile

### All Instructions Explained

| Instruction | What it does | Example |
|---|---|---|
| `FROM` | Set the base image (always first!) | `FROM node:18-alpine` |
| `WORKDIR` | Set working directory inside container | `WORKDIR /app` |
| `COPY` | Copy files from host to container | `COPY . /app` |
| `ADD` | Like COPY but handles URLs & tar files | `ADD app.tar.gz /app` |
| `RUN` | Execute command during build | `RUN npm install` |
| `CMD` | Default command when container starts (overridable) | `CMD ["node","server.js"]` |
| `ENTRYPOINT` | Fixed command (CMD args append to it) | `ENTRYPOINT ["python"]` |
| `EXPOSE` | Document which port the app uses | `EXPOSE 3000` |
| `ENV` | Set environment variables | `ENV NODE_ENV=production` |
| `ARG` | Build-time variable (only during build) | `ARG VERSION=1.0` |
| `VOLUME` | Create a mount point for volumes | `VOLUME /data` |
| `USER` | Set user for subsequent commands | `USER node` |
| `LABEL` | Add metadata to the image | `LABEL version="1.0"` |

---

### Example 1 — Node.js App

```dockerfile
# 1. Start from official Node image (alpine = small size)
FROM node:18-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy package.json FIRST (for caching benefit)
COPY package*.json ./

# 4. Install dependencies
RUN npm install

# 5. Copy rest of the code
COPY . .

# 6. Set env variable
ENV PORT=3000

# 7. Document the port
EXPOSE 3000

# 8. Start the app
CMD ["node", "server.js"]
```

---

### Example 2 — Python Flask App

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

---

### Multi-Stage Build (Best Practice)

> **Why?** Build stage has all dev tools. Final stage has ONLY the output. Result: **tiny production image**.

```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Serve (only copy the built output!)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
# Result: tiny nginx image, no node_modules!
```

---

### .dockerignore File

> Always create this! Tells Docker what NOT to copy — like `.gitignore` but for builds.

```
node_modules
.git
.env
*.log
README.md
dist
```

---

## 5. Essential Commands

### 🖼️ Image Commands

```bash
# Pull an image from Docker Hub
docker pull nginx:latest

# Build image from Dockerfile in current dir
docker build -t myapp:1.0 .

# List all local images
docker images

# Remove an image
docker rmi myapp:1.0

# Remove all unused images
docker image prune -a

# Push image to Docker Hub
docker push username/myapp:1.0

# Inspect image details (layers, env, etc.)
docker inspect myapp:1.0
```

---

### 📦 Container Commands

```bash
# Run a container (basic)
docker run nginx

# Run in background (detached)
docker run -d nginx

# Run with port mapping  host:container
docker run -d -p 8080:80 nginx

# Run with a name
docker run -d --name my-nginx -p 8080:80 nginx

# Run with environment variable
docker run -e NODE_ENV=production myapp

# Run interactively (bash shell)
docker run -it ubuntu bash

# Run and auto-remove when stopped
docker run --rm ubuntu echo "hello"

# List running containers
docker ps

# List ALL containers (including stopped)
docker ps -a

# Stop a container
docker stop my-nginx

# Start a stopped container
docker start my-nginx

# Remove a container
docker rm my-nginx

# Force remove running container
docker rm -f my-nginx

# View container logs
docker logs my-nginx

# Follow logs in real time
docker logs -f my-nginx

# Execute command inside running container
docker exec -it my-nginx bash

# Copy file from container to host
docker cp my-nginx:/etc/nginx/nginx.conf ./nginx.conf

# View resource usage
docker stats
```

---

### 🧹 Cleanup Commands

```bash
# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune -a

# Remove all unused volumes
docker volume prune

# Nuclear option: clean EVERYTHING unused
docker system prune -a

# Show disk usage
docker system df
```

---

### `docker run` Flags Reference

| Flag | Meaning | Example |
|---|---|---|
| `-d` | Run in background (detached) | `docker run -d nginx` |
| `-p` | Port mapping host:container | `-p 8080:80` |
| `-v` | Mount volume | `-v ./data:/data` |
| `-e` | Environment variable | `-e DB_HOST=localhost` |
| `--name` | Container name | `--name my-app` |
| `-it` | Interactive + TTY (for shell) | `-it ubuntu bash` |
| `--rm` | Auto-delete when stopped | `--rm alpine echo hi` |
| `--network` | Attach to a network | `--network my-net` |
| `--restart` | Restart policy | `--restart always` |
| `-m` | Memory limit | `-m 512m` |

---

## 6. Docker Networking

### Network Types

| Type | Description | Best For |
|---|---|---|
| **Bridge** (default) | Containers on same bridge can talk. Access outside via port mapping. | Single-host apps |
| **Host** | Container uses host's network directly (no isolation). Faster, less secure. | Linux performance needs |
| **None** | No networking at all. Completely isolated. | Batch security tasks |
| **Overlay** | Connects containers across multiple Docker hosts. | Docker Swarm / clusters |

---

### Custom Bridge Network Diagram

```
         🌍 Internet / Browser
                  ↕ Port 8080:80
┌─────────────────────────────────────────┐
│         my-network  (Bridge)            │
│                                         │
│  ┌──────────┐  ┌──────────┐  ┌───────┐ │
│  │  web     │⇄ │  api     │⇄ │  db   │ │
│  │  :80     │  │  :3000   │  │  :5432│ │
│  │  nginx   │  │  node    │  │  pg   │ │
│  └──────────┘  └──────────┘  └───────┘ │
└─────────────────────────────────────────┘
```

> **Key:** On a custom network, containers reference each other by **name** (e.g. `http://db:5432`). DNS is built-in!

---

### Network Commands

```bash
# List networks
docker network ls

# Create a custom bridge network
docker network create my-network

# Run container on a specific network
docker run --network my-network --name db postgres

# Connect existing container to a network
docker network connect my-network my-container

# Disconnect
docker network disconnect my-network my-container

# Inspect a network
docker network inspect my-network

# Remove a network
docker network rm my-network
```

---

## 7. Docker Volumes

> Container filesystem is **temporary** — when a container is removed, data is lost. Volumes store data **outside** the container on the host.

### 3 Types of Storage

| Type | Description | Flag Syntax |
|---|---|---|
| **Named Volume** | Managed by Docker. Best for production. Persists after container removal. | `-v mydata:/data` |
| **Bind Mount** | Maps a specific host folder. Great for dev — live code reload! | `-v ./src:/app/src` |
| **tmpfs Mount** | In-memory only. Super fast but lost on stop. For sensitive temp data. | `--tmpfs /tmp` |

---

### Volume Commands

```bash
# Create a named volume
docker volume create mydata

# List volumes
docker volume ls

# Inspect a volume (see where it's stored)
docker volume inspect mydata

# Use named volume with container
docker run -v mydata:/var/lib/postgresql/data postgres

# Bind mount current dir into container (dev workflow)
docker run -v $(pwd):/app -p 3000:3000 node:18 npm start

# Remove a volume
docker volume rm mydata

# Remove all unused volumes
docker volume prune
```

---

### Real Example: PostgreSQL with Persistence

```bash
# Without volume — data LOST when container stops!
docker run -e POSTGRES_PASSWORD=secret postgres

# With volume — data PERSISTS!
docker run -d \
  -e POSTGRES_PASSWORD=secret \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  --name my-postgres \
  postgres:15
```

---

## 8. Docker Compose

> Managing multiple containers with individual `docker run` commands is painful. **Docker Compose** lets you define your entire multi-container app in **one YAML file** and start everything with one command.

```bash
docker compose up    # starts all containers
docker compose down  # stops and removes them all
```

---

### docker-compose.yml — Full Stack Example

```yaml
# docker-compose.yml
version: '3.8'

services:

  # Frontend (React)
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
    environment:
      - REACT_APP_API=http://localhost:5000

  # Backend (Node.js API)
  backend:
    build: ./backend
    ports:
      - "5000:5000"
    depends_on:
      - db
    environment:
      - DB_HOST=db
      - DB_PASSWORD=secret
    volumes:
      - ./backend:/app   # bind mount for dev

  # Database (PostgreSQL)
  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=myapp
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  pgdata:   # named volume
```

---

### Compose Architecture

```
       🌍 Browser (Port 3000)
               ↕
┌──────────────────────────────────────┐
│        docker compose (app-network)  │
│                                      │
│  frontend:3000 → backend:5000 → db:5432
│     React          Node API     PostgreSQL
└──────────────────────────────────────┘
               ↕
       💾 pgdata Volume (persisted)
```

---

### Docker Compose Commands

```bash
# Start all services (build if needed)
docker compose up

# Start in background
docker compose up -d

# Rebuild images and start
docker compose up --build

# Stop and remove containers + networks
docker compose down

# Stop and remove + volumes
docker compose down -v

# View running services
docker compose ps

# View logs of all services
docker compose logs -f

# View logs of one service
docker compose logs -f backend

# Run a one-off command in a service
docker compose exec backend bash

# Scale a service to 3 instances
docker compose up --scale backend=3

# Restart a single service
docker compose restart backend
```

---

## 9. Integrations

### Common Tool Integrations

| Tool | What it does |
|---|---|
| **GitHub Actions** | Auto-build & push Docker images on every commit/PR |
| **Kubernetes** | Orchestrate Docker containers at massive scale |
| **VS Code Dev Containers** | Develop inside a container — reproducible dev environments |
| **Jenkins** | Run CI/CD pipelines inside Docker containers |
| **AWS ECS / EKS** | Deploy Docker containers on AWS managed services |
| **Docker Swarm** | Native Docker clustering for multi-host deployments |
| **Terraform** | Provision infra + deploy Docker containers as code |
| **Prometheus + Grafana** | Monitor container metrics and visualize dashboards |

---

### CI/CD Pipeline Flow

```
DEV       → git push to GitHub
             └─ Developer pushes code

CI        → GitHub Actions triggers
             └─ Tests run inside Docker container, then image is built

REGISTRY  → docker push to Docker Hub / ECR
             └─ Tagged image (e.g. myapp:v1.2.3) pushed to registry

DEPLOY    → Pull & deploy on server
             └─ Server pulls new image, runs updated container (zero downtime)
```

---

### GitHub Actions Workflow

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
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          push: true
          tags: username/myapp:latest
```

---

### VS Code Dev Containers

> **Dev Containers** let you develop *inside* a Docker container. Your entire dev environment (extensions, tools, dependencies) is defined in code.

```json
// .devcontainer/devcontainer.json
{
  "name": "My Node App",
  "image": "mcr.microsoft.com/devcontainers/node:18",
  "forwardPorts": [3000],
  "postCreateCommand": "npm install",
  "extensions": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint"
  ]
}
```

---

## 10. Cheat Sheet

### 🏃 Most Used Commands

| Task | Command |
|---|---|
| Run nginx on port 8080 | `docker run -d -p 8080:80 --name web nginx` |
| Build image | `docker build -t myapp:1.0 .` |
| See running containers | `docker ps` |
| Get a shell inside container | `docker exec -it CONTAINER bash` |
| View logs live | `docker logs -f CONTAINER` |
| Stop & remove all | `docker stop $(docker ps -q) && docker rm $(docker ps -aq)` |
| Start compose stack | `docker compose up -d` |
| Stop compose stack | `docker compose down` |
| Pull latest image | `docker pull IMAGE:latest` |
| Push to registry | `docker push username/IMAGE:tag` |
| Clean everything unused | `docker system prune -a` |
| See resource usage | `docker stats` |

---

### ✅ Dockerfile Best Practices

**Do:**
- Use `alpine` / `slim` base images (smaller size)
- `COPY package.json` before `COPY .` (better caching)
- Always use `.dockerignore`
- Use multi-stage builds for production
- Pin image versions (`node:18`, not `node:latest`)
- Run as non-root `USER`
- One process per container

**Avoid:**
- `COPY . .` before installing dependencies
- Using `:latest` in production
- Storing secrets in Dockerfile
- Running as root
- Too many separate `RUN` commands (chain with `&&`)
- Ignoring `.dockerignore`
- Large base images when a small one works

---

### 🗺️ Concepts Map

```
🐳 Docker
├── Image          ← built from Dockerfile (docker build)
├── Container      ← running image (docker run)
├── Registry       ← remote image storage (Docker Hub)
├── Volume         ← persistent data storage
├── Network        ← container communication
└── Compose        ← multi-container app definition
```

---

> **Learning Path:** Intro → Run your first container (`docker run hello-world`) → Write a Dockerfile → Compose a multi-service app → Integrate with CI/CD. That's the full journey! 🚀