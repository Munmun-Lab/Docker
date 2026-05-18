# Docker Dockerfile Example for a Windows-Based Application

A Dockerfile is basically:

```text id="pp0c7p"
Blueprint / Instructions
to build a container image
```

For Windows applications, Docker uses:

* Windows base images
* Windows containers
* IIS / .NET / PowerShell apps

---

# Simple Understanding

```text id="uow8j0"
Application Files
      ↓
Dockerfile
      ↓
Docker Image
      ↓
Docker Container
```

---

# Example Scenario

Suppose you have:

* A simple ASP.NET web application
* Running on Windows IIS

Folder:

```text id="t78p7f"
myapp/
 ├── index.html
 └── Dockerfile
```

---

# Simple Windows Dockerfile Example

```dockerfile id="1mp1f3"
# Use Windows IIS Base Image
FROM mcr.microsoft.com/windows/servercore/iis

# Copy application files into IIS web folder
COPY index.html C:/inetpub/wwwroot/

# Expose web port
EXPOSE 80
```

---

# What Each Line Means

| Line   | Meaning                       |
| ------ | ----------------------------- |
| FROM   | Base Windows OS image         |
| COPY   | Copy app files into container |
| EXPOSE | Open container port           |

---

# Build the Image

```powershell id="lb0g8k"
docker build -t my-windows-app .
```

Meaning:

```text id="8l6j7z"
Build Docker image
named my-windows-app
```

---

# Run the Container

```powershell id="d0q25j"
docker run -d -p 8080:80 my-windows-app
```

Meaning:

| Part           | Meaning                    |
| -------------- | -------------------------- |
| -d             | Run in background          |
| -p 8080:80     | Host Port → Container Port |
| my-windows-app | Image name                 |

---

# Access the Application

Open browser:

```text id="kgtx8u"
http://localhost:8080
```

---

# Visual Flow

```text id="4r94yc"
Dockerfile
    ↓
docker build
    ↓
Docker Image
    ↓
docker run
    ↓
Running Windows Container
```

---

# Real Enterprise Example

For enterprise Windows apps:

```dockerfile id="ivbxpn"
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /app

COPY . .

EXPOSE 80
```

Used for:

* ASP.NET Framework apps
* IIS applications
* Internal enterprise portals

---

# Important Windows Container Concepts

| Concept           | Meaning                          |
| ----------------- | -------------------------------- |
| Windows Container | Runs Windows OS inside container |
| Base Image        | Prebuilt Windows OS image        |
| IIS               | Microsoft Web Server             |
| ServerCore        | Lightweight Windows image        |
| Nano Server       | Smaller Windows image            |

---

# Linux vs Windows Containers

| Linux Containers    | Windows Containers     |
| ------------------- | ---------------------- |
| Most common         | Enterprise legacy apps |
| Small size          | Larger size            |
| Fast startup        | Slower startup         |
| Kubernetes friendly | Limited K8s support    |
| Nginx/Apache        | IIS/.NET               |

---

# Important Requirement

To run Windows containers:

* Docker Desktop must be in:

```text id="amw6gw"
Switch to Windows Containers
```

Because default mode is Linux containers.

---

# Real-World Use Cases

Windows Docker commonly used for:

* Legacy .NET applications
* IIS hosting
* Internal enterprise apps
* Windows services
* Lift-and-shift modernization

---

# Where This Fits in Infrastructure

```text id="2b9fnh"
Infrastructure
   ↓
Virtualization
   ↓
Containers
   ↓
Docker
   ↓
Kubernetes
```

This is why Docker is heavily used in:

* DevOps
* Cloud Engineering
* Platform Engineering
* SRE
* Modern Infrastructure Teams
