# Docker Multi-Stage Docker Build for Windows Application

Example:

* Windows ASP.NET application
* IIS web server
* Multi-stage Docker build
* Build → Package → Run

---

# Scenario

Suppose you have:

```text id="c5ohv6"
my-dotnet-app/
 ├── MyApp.sln
 ├── MyWebApp/
 │    ├── Default.aspx
 │    ├── Web.config
 │    └── MyWebApp.csproj
 └── Dockerfile
```

---

# Goal

```text id="0q0m7s"
Stage 1:
Build application

Stage 2:
Create lightweight runtime image

Final:
Run application in IIS container
```

---

# Multi-Stage Dockerfile (Windows)

```dockerfile id="9n8k4x"
# =========================
# Stage 1 - Build Stage
# =========================

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder

WORKDIR /src

# Copy source code
COPY . .

# Build application
RUN msbuild MyWebApp/MyWebApp.csproj /p:Configuration=Release


# =========================
# Stage 2 - Runtime Stage
# =========================

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

# Copy built application from builder stage
COPY --from=builder /src/MyWebApp/bin/Release/ .

# Expose IIS port
EXPOSE 80
```

---

# What Happens Here

## Stage 1 → Builder

```dockerfile id="zw74k5"
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder
```

Uses:

* Full .NET SDK
* Compiler tools
* MSBuild

Purpose:

```text id="i8pwsv"
Compile application
```

---

## Copy Source Code

```dockerfile id="h5n3z3"
COPY . .
```

Copies:

```text id="4yjsa9"
Local project files
→ into container build environment
```

---

## Build Application

```dockerfile id="gqnh1l"
RUN msbuild MyWebApp/MyWebApp.csproj /p:Configuration=Release
```

Creates:

```text id="czpm6v"
Compiled application binaries
```

---

# Stage 2 → Runtime

```dockerfile id="apj10u"
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8
```

Uses:

* Lightweight IIS runtime image
* No SDK tools
* Smaller production image

---

# Copy From Previous Stage

```dockerfile id="dlw3yn"
COPY --from=builder /src/MyWebApp/bin/Release/ .
```

This is the key multi-stage concept.

Meaning:

```text id="h1i2uk"
Take compiled files
FROM builder stage
TO runtime IIS image
```

---

# Visual Flow

```text id="ws31po"
LOCAL SOURCE CODE
        ↓

+-------------------+
| Stage 1 Builder   |
| SDK + MSBuild     |
| Compile App       |
+-------------------+
        ↓

Compiled Files (.dll/.aspx)
        ↓

+-------------------+
| Stage 2 Runtime   |
| IIS + ASP.NET     |
| Lightweight Image |
+-------------------+
        ↓

Final Production Container
```

---

# Build Docker Image

```powershell id="jlwm3m"
docker build -t windows-webapp:v1 .
```

---

# Run Container

```powershell id="7b5plu"
docker run -d -p 8080:80 --name winapp windows-webapp:v1
```

---

# Access Application

Browser:

```text id="lzjlwm"
http://localhost:8080
```

---

# Why Multi-Stage Build?

## Without Multi-Stage

Image contains:

* SDK
* Compiler
* Temp files
* Source code

Result:

```text id="gdr2xz"
Very large image
```

---

## With Multi-Stage

Final image contains only:

* Runtime
* IIS
* Compiled application

Result:

```text id="jlwm2g"
Smaller + Faster + More Secure
```

---

# Multiple Docker Layers

Every instruction creates a layer.

Example:

```dockerfile id="jlwm4f"
FROM ...
WORKDIR ...
COPY ...
RUN ...
EXPOSE ...
```

Each step:

```text id="jlwm5h"
creates separate Docker layer
```

---

# Layer Example

```text id="xk7m2r"
Layer 1 → Base Windows Image
Layer 2 → IIS Runtime
Layer 3 → Application Files
Layer 4 → Configuration
```

Docker caches these layers for faster builds.

---

# Enterprise Best Practices

## Use `.dockerignore`

```text id="jlwm6t"
bin/
obj/
.git/
.vscode/
```

Avoids unnecessary files in image.

---

## Use Tagged Images

```dockerfile id="jlwm7u"
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8
```

instead of:

```dockerfile id="jlwm8v"
latest
```

---

## Keep Runtime Image Small

Only copy:

* binaries
* configs
* runtime dependencies

---

# Real Enterprise Workflow

```text id="9v9rwl"
Developer Pushes Code
        ↓
GitHub / GitLab
        ↓
CI/CD Pipeline
        ↓
Docker Multi-Stage Build
        ↓
Container Registry
        ↓
Kubernetes / Docker Runtime
        ↓
Production Deployment
```

---

# Where This Fits

| Technology        | Role                        |
| ----------------- | --------------------------- |
| Docker            | Containerization            |
| Multi-Stage Build | Optimized Image Creation    |
| IIS               | Web Server                  |
| Windows Container | Runtime Platform            |
| Kubernetes        | Container Orchestration     |
| Terraform         | Infrastructure Provisioning |

---

# Important Reality in Industry

Today:

* Linux containers dominate cloud-native apps
* Windows containers mostly used for:

  * Legacy .NET Framework apps
  * IIS applications
  * Enterprise internal systems

Modern .NET applications usually move toward:

* Linux containers
* .NET Core / .NET 8
* Kubernetes-friendly architecture
