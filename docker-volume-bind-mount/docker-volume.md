# Docker Docker Volumes, Bind Mounts & Persistent Storage

# 1. Why Persistent Storage is Needed in Docker?

## Problem Statement

Docker containers are:

```text id="m1z8xr"
Ephemeral / Temporary
```

Meaning:

* When container is deleted
* All internal data is lost

---

# Example Problem

Suppose:

* MySQL database runs inside container
* Customer/payment/order data stored inside container filesystem

If container crashes or is deleted:

```text id="y8q3vn"
All database data disappears
```

This is a major production issue.

---

# Without Persistent Storage

```text id="g6m2kp"
Container Created
      ↓
Application Writes Data
      ↓
Container Deleted
      ↓
Data Lost ❌
```

---

# Solution

Docker provides:

* Bind Mounts
* Volumes

to store data outside container lifecycle.

---

# Persistent Storage Architecture

```text id="u2n7qw"
Docker Container
       ↓
Mounted Storage
       ↓
Host Storage / Docker Volume
       ↓
Data Persists Even After Container Removal
```

---

# 2. Bind Mounts

## What is Bind Mount?

Bind mount directly maps:

* Host machine directory
  → into container

---

# Bind Mount Architecture

```text id="d5x1tp"
Host Machine Folder
(/home/user/data)
        ↓
Bind Mount
        ↓
Container Folder
(/app/data)
```

---

# Bind Mount Example

## Host Folder

```text id="w8r4ny"
/home/docker/website
```

Contains:

```text id="a3k7pm"
index.html
style.css
```

---

# Run Container with Bind Mount

```bash id="n9v1qs"
docker run -d \
-p 8080:80 \
-v /home/docker/website:/usr/share/nginx/html \
nginx
```

---

# Understanding

| Host Path            | Container Path        |
| -------------------- | --------------------- |
| /home/docker/website | /usr/share/nginx/html |

Meaning:

```text id="q6m4zc"
Host files become accessible inside container
```

---

# Real-Time Bind Mount Use Cases

| Use Case            | Purpose                      |
| ------------------- | ---------------------------- |
| Development         | Live code changes            |
| Configuration Files | Share configs                |
| Logs                | Store logs outside container |
| Local Testing       | Easy debugging               |

---

# Bind Mount Flow

```text id="r3x9mk"
Developer Updates File
        ↓
Host Folder Changes
        ↓
Container Immediately Sees Changes
```

---

# Problems with Bind Mounts

| Issue              | Explanation                        |
| ------------------ | ---------------------------------- |
| Host Dependency    | Path must exist on host            |
| OS-specific        | Linux/Windows path issues          |
| Security Risk      | Container accesses host filesystem |
| Portability Issues | Hard to migrate                    |
| Backup Complexity  | Manual management                  |

---

# 3. Docker Volumes

## What is Docker Volume?

Docker-managed persistent storage.

Docker itself manages:

* storage
* lifecycle
* location

---

# Volume Architecture

```text id="z1k6tw"
Docker Container
       ↓
Docker Volume
       ↓
Docker Managed Storage
(/var/lib/docker/volumes/)
```

---

# Volume Example

## Create Volume

```bash id="x8t2rm"
docker volume create mysql-data
```

---

# Run MySQL Container with Volume

```bash id="b7p4qk"
docker run -d \
--name mysql-db \
-e MYSQL_ROOT_PASSWORD=root123 \
-v mysql-data:/var/lib/mysql \
mysql:8.0
```

---

# Understanding

| Docker Volume | Container Path |
| ------------- | -------------- |
| mysql-data    | /var/lib/mysql |

Meaning:

```text id="n4w8zy"
Database data stored safely outside container
```

---

# Volume Flow

```text id="f9y2ql"
Container Writes Data
        ↓
Docker Volume Stores Data
        ↓
Container Deleted
        ↓
Data Still Exists ✅
```

---

# Verify Volumes

```bash id="j6v3pw"
docker volume ls
```

---

# Inspect Volume

```bash id="u7x9mr"
docker volume inspect mysql-data
```

---

# 4. Advantages of Volumes over Bind Mounts

| Feature                    | Bind Mount | Docker Volume |
| -------------------------- | ---------- | ------------- |
| Docker Managed             | ❌          | ✅             |
| Portable                   | ❌          | ✅             |
| Secure                     | Medium     | Better        |
| Easy Backup                | Medium     | Easy          |
| Performance                | Medium     | Better        |
| OS Independent             | ❌          | ✅             |
| Recommended for Production | ❌          | ✅             |

---

# Why Enterprises Prefer Volumes

Volumes:

* work better with Kubernetes
* easier for backups
* easier for migration
* safer for production databases

---

# 5. Lifecycle of Docker Volumes

## Volume Lifecycle

```text id="s5m8qy"
Volume Created
      ↓
Container Uses Volume
      ↓
Container Deleted
      ↓
Volume Still Exists
      ↓
Volume Manually Removed
```

---

# Important Point

Deleting container:

```bash id="y2t7vx"
docker rm container-name
```

DOES NOT delete volume.

---

# Remove Volume Manually

```bash id="c4r9pn"
docker volume rm mysql-data
```

---

# Remove Unused Volumes

```bash id="w1z6qm"
docker volume prune
```

---

# 6. How to Mount a Volume

---

# Named Volume Mount

```bash id="m8q2vt"
docker run -d \
-v app-data:/app/data \
nginx
```

---

# Bind Mount

```bash id="e3p7kx"
docker run -d \
-v /host/path:/container/path \
nginx
```

---

# Read-Only Mount

```bash id="g5x1zw"
docker run -d \
-v app-data:/app/data:ro \
nginx
```

Meaning:

```text id="t7m3qp"
Container can only read data
```

---

# Mount Using --mount

Modern syntax:

```bash id="r9v4mx"
docker run -d \
--mount source=mydata,target=/app/data \
nginx
```

---

# 7. Docker Compose Example

## Persistent Database Storage

```yaml id="k2y8qn"
version: '3'

services:

  mysql:
    image: mysql:8.0

    environment:
      MYSQL_ROOT_PASSWORD: root123

    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

---

# Compose Flow

```text id="v8q5mr"
Docker Compose
       ↓
Creates Volume
       ↓
Attaches to MySQL
       ↓
Database Persists
```

---

# 8. Real Production Architecture

```text id="h6w2zp"
Application Container
         ↓
Persistent Volume
         ↓
Cloud Storage / SSD
         ↓
Backup & Disaster Recovery
```

---

# Enterprise Storage Examples

| Platform   | Persistent Storage      |
| ---------- | ----------------------- |
| Docker     | Volumes                 |
| Kubernetes | Persistent Volumes (PV) |
| AWS        | EBS / EFS               |
| Azure      | Managed Disks           |
| VMware     | Datastores              |

---

# 9. Common Real-World Use Cases

| Application   | Why Persistent Storage |
| ------------- | ---------------------- |
| MySQL         | Store database         |
| PostgreSQL    | Store transactions     |
| Jenkins       | Store pipelines/jobs   |
| Prometheus    | Store metrics          |
| Grafana       | Store dashboards       |
| Elasticsearch | Store logs             |
| SonarQube     | Store analysis data    |

---

# 10. Important Docker Storage Commands

## Volume Commands

```bash id="q9x3vk"
docker volume create myvolume
docker volume ls
docker volume inspect myvolume
docker volume rm myvolume
docker volume prune
```

---

# Container Mount Verification

```bash id="b1t6qm"
docker inspect container-name
```

---

# Disk Usage

```bash id="y4v8pk"
docker system df
```

---

# 11. Best Practices

| Best Practice                      | Reason              |
| ---------------------------------- | ------------------- |
| Use Volumes for Databases          | Persistent & secure |
| Avoid Bind Mounts in Production    | Host dependency     |
| Backup Volumes Regularly           | DR & recovery       |
| Use Read-Only Mounts When Possible | Security            |
| Use Named Volumes                  | Better portability  |

---

# 12. Kubernetes Mapping

Docker concepts map directly into Kubernetes:

| Docker            | Kubernetes        |
| ----------------- | ----------------- |
| Volume            | Persistent Volume |
| Bind Mount        | HostPath          |
| Container Storage | PVC               |

---

# 13. Interview Short Summary

```text id="c7w4zn"
Docker volumes provide persistent, Docker-managed storage that survives container deletion, while bind mounts directly map host directories into containers. Volumes are preferred in production because they are portable, secure, and easier to manage.
```

