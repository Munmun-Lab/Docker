# Docker Multi-Stage Docker Build

Multi-stage Docker build is a Docker feature where multiple stages are used within a single Dockerfile to separate the build environment from the runtime environment.

It helps:

* Reduce final image size
* Remove unnecessary build tools and dependencies
* Improve security
* Optimize CI/CD deployments

Typical flow:

```text id="y3b0qt"
Build Stage → Compile Application
Runtime Stage → Run Only Required Files
```

---

# Distroless Images

Distroless images are minimal container images that contain:

* Only the application runtime and required libraries
* No package manager
* No shell
* No unnecessary OS utilities

Benefits:

* Very small image size
* Better security
* Reduced attack surface
* Faster deployments

---

# Approximate Image Size Comparison

| Image Type             | Approx Size         |
| ---------------------- | ------------------- |
| Full OS Base Image     | 500 MB – several GB |
| Standard Runtime Image | 150–300 MB          |
| Alpine-based Image     | 5–50 MB             |
| Distroless Image       | 10–40 MB            |

---

# Interview One-Line Summary

```text id="n0g7hd"
Multi-stage builds optimize Docker images by separating build and runtime stages, while distroless images minimize container size and security exposure by removing unnecessary OS components.
```
---

# Docker Distroless Image Example

## Goal

* Run a very small secure container
* Validate CPU & Memory utilization
* Access server using PuTTY (SSH)

---

# Simple Flow

```text id="m3t9xp"
PuTTY
  ↓
Linux Server / VPS
  ↓
Docker Container
  ↓
docker stats
  ↓
CPU & Memory Monitoring
```

---

# Minimal Distroless Dockerfile

```dockerfile id="q8r2vn"
# Build Stage
FROM golang:1.24 AS builder

WORKDIR /app

COPY . .

RUN go build -o monitor-app .


# Distroless Runtime Stage
FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/monitor-app .

ENTRYPOINT ["/app/monitor-app"]
```

---

# Why This Is Distroless

Final image contains:

* Only application binary
* Required runtime libraries

It does NOT contain:

* bash
* yum
* apt
* package managers
* shell utilities

Result:

```text id="x2f7ld"
Very small + secure image
```

---

# Build Image

```bash id="f5h8qw"
docker build -t monitor-app .
```

---

# Run Container

```bash id="w7p3nk"
docker run -d --name monitor monitor-app
```

---

# Validate CPU & Memory Usage

SSH into server using:

* PuTTY

Then run:

```bash id="c1n6rm"
docker stats
```

Example output:

```text id="k8z4bv"
CONTAINER ID   NAME      CPU %     MEM USAGE
8ab123cd       monitor   1.25%     45MiB
```

---

# Interview Summary

```text id="n4x7qa"
Distroless images contain only application runtime dependencies, making containers smaller and more secure. CPU and memory utilization can be validated using docker stats after connecting through PuTTY or SSH.
```

