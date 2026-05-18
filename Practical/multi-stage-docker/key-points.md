## Multi-Stage Docker Builds

Multi-stage builds let you use multiple `FROM` statements in a single Dockerfile, allowing you to separate the **build environment** from the **runtime environment** — resulting in much smaller, cleaner final images.

### Why Use Multi-Stage Builds?

- **Smaller images** — build tools, compilers, and intermediate files don't end up in production
- **Better security** — fewer packages = smaller attack surface
- **Cleaner separation** — build logic stays isolated from runtime logic
- **No separate Dockerfiles** — one file handles everything

---

### Basic Pattern

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

The key instruction is `COPY --from=<stage>`, which pulls files from a previous stage.

---

### Common Patterns by Language

**Go** (produces a single binary — ideal for scratch images)
```dockerfile
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o server .

FROM scratch AS production
COPY --from=builder /app/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
```

**Java / Maven**
```dockerfile
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

FROM eclipse-temurin:21-jre-alpine AS production
WORKDIR /app
COPY --from=builder /app/target/app.jar .
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

**Python**
```dockerfile
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

FROM python:3.12-slim AS production
COPY --from=builder /install /usr/local
WORKDIR /app
COPY . .
CMD ["python", "main.py"]
```

---

### Advanced Features

**Named stages for selective targeting**
```dockerfile
FROM node:20 AS deps
FROM node:20 AS test          # extends deps
FROM node:20 AS production    # extends deps, skips test
```

Build only a specific stage:
```bash
docker build --target builder -t myapp:build .
docker build --target production -t myapp:latest .
```

**Reusing external images as stages**
```dockerfile
COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
```

**Multiple independent build stages merged into one**
```dockerfile
FROM node:20 AS frontend-builder
RUN npm run build

FROM golang:1.22 AS backend-builder
RUN go build -o api .

FROM alpine AS final
COPY --from=frontend-builder /app/dist ./static
COPY --from=backend-builder /app/api ./api
CMD ["./api"]
```

---

### Size Comparison Example

| Approach | Image Size |
|---|---|
| Single stage (node:20) | ~1.1 GB |
| Multi-stage (alpine runtime) | ~150 MB |
| Multi-stage (distroless) | ~90 MB |
| Go + scratch | ~10–20 MB |

---

### Key Tips

- **Order `COPY` and `RUN` by change frequency** — put stable things (dependencies) before volatile things (source code) to maximize layer cache hits
- **Use `AS` names** — makes `--from` references readable and lets you use `--target` during builds
- **`scratch`** is a valid base for statically compiled binaries (Go, Rust) — it has zero OS overhead
- **`distroless`** images (from Google) are a good middle ground — no shell, but have libc and CA certs

---

---

## `scratch` in Docker

`scratch` is a **completely empty base image** — no OS, no shell, no files whatsoever. It's Docker's reserved minimal image.

```dockerfile
FROM scratch
COPY --from=builder /app/server /server
ENTRYPOINT ["/server"]
```

### What it contains
Literally **nothing**. No:
- Shell (`sh`, `bash`)
- Package manager
- libc / system libraries
- CA certificates

### When to use it
Only works for **statically compiled binaries** — Go and Rust are the most common:

```go
// Go: build a truly static binary
CGO_ENABLED=0 GOOS=linux go build -o server .
```

### Pros & Cons

| ✅ Pros | ❌ Cons |
|---|---|
| Smallest possible image (MBs) | Can't `docker exec` into it (no shell) |
| Zero attack surface | No debugging tools |
| Nothing unnecessary ships | Must bundle CA certs manually if needed HTTPS |

### CA certs workaround (if your app makes HTTPS calls)
```dockerfile
FROM alpine AS certs
RUN apk add ca-certificates

FROM scratch
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/server /server
ENTRYPOINT ["/server"]
```

**Bottom line:** `scratch` = maximum minimalism. Great for Go/Rust microservices in production; impractical for anything that needs an OS or dynamic linking.
