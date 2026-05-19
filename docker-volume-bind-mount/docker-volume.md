# Docker Docker Volumes, Bind Mounts & Persistent Storage

# 1. Why Persistent Storage is Needed in Docker?

## Problem Statement

It is a very common requirement to persist the data in a Docker container beyond the lifetime of the container. However, the file system
of a Docker container is deleted/removed when the container dies. 

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

# Problem Visualization

```text id="h5x1tr"
Docker Container
 ├── Application
 ├── Logs
 ├── Database Files
 └── Temporary Storage

Container Deleted
       ↓
All Data Deleted
```

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

# Why Persistent Storage Needed?

Needed for:

* Databases
* Application uploads
* Logs
* Configuration files
* Backups
* Shared storage

---

# Docker Persistent Storage Solutions

| Type           | Description                    |
| -------------- | ------------------------------ |
| Bind Mounts    | Mount local host directory     |
| Docker Volumes | Docker-managed storage         |
| tmpfs Mounts   | Memory-based temporary storage |

to store data outside container lifecycle.

---

# Persistent Storage Architecture

```text id="r9v4pl"
Application Container
        ↓
Persistent Storage
   ├── Bind Mount
   └── Docker Volume
```

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

Bind mounts also aims to solve the same problem but in a complete different way.

Using this way, user can mount a directory from the host file system into a container. Bind mounts have the same behavior as volumes, but
are specified using a host path instead of a volume name. 

For example, 

```
docker run -it -v <host_path>:<container_path> <image_name> /bin/bash
```

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

```text id="c6t1wx"
Host Server
 └── /data/mysql

        ↓ Mounted

Docker Container
 └── /var/lib/mysql
```

---

# Bind Mount Command

```bash id="m1p8vr"
docker run -d \
-v /host-data:/container-data \
nginx
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

# Example

```bash id="t5x3qn"
docker run -d \
-v /home/user/website:/usr/share/nginx/html \
-p 8080:80 nginx
```

---

# What Happens?

```text id="w2n9kp"
Host Folder:
 /home/user/website

Mapped To:
 /usr/share/nginx/html

inside container
```

# Real-Time Bind Mount Use Cases

| Use Case            | Purpose                      |
| ------------------- | ---------------------------- |
| Development         | Live code changes            |
| Configuration Files | Share configs                |
| Logs                | Store logs outside container |
| Local Testing       | Easy debugging               |

# Bind Mount Use Cases

| Use Case      | Example           |
| ------------- | ----------------- |
| Development   | Live code changes |
| Config files  | nginx.conf        |
| Log sharing   | App logs          |
| Local testing | Web development   |


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

Docker-managed persistent storage. Volumes aims to solve the same problem by providing a way to store data on the host file system, separate from the container's file system, 
so that the data can persist even if the container is deleted and recreated.

![image](https://user-images.githubusercontent.com/43399466/218018334-286d8949-d155-4d55-80bc-24827b02f9b1.png)

Docker itself manages:

* storage
* lifecycle
* location

Volumes can be created and managed using the docker volume command. You can create a new volume using the following command:

```
docker volume create <volume_name>
```

Once a volume is created, you can mount it to a container using the -v or --mount option when running a docker run command. 

For example:

```
docker run -it -v <volume_name>:/data <image_name> /bin/bash
```

This command will mount the volume <volume_name> to the /data directory in the container. Any data written to the /data directory
inside the container will be persisted in the volume on the host file system.

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

```text id="s8w2cn"
Docker Volume
      ↓
Managed by Docker Engine
      ↓
Mounted into Container
```

---

# Volume Storage Location

Linux:

```text id="x5r1md"
/var/lib/docker/volumes/
```

Windows:

```text id="b9t4kv"
C:\ProgramData\Docker\volumes\
```

---

# Volume Example

## Create Volume

```bash id="x8t2rm"
docker volume create mysql-data
```

---

# Mount Volume

```bash id="p4z8nx"
docker run -d \
-v mysql-data:/var/lib/mysql \
mysql
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

# Architecture Diagram

```text id="g3v9rc"
Docker Volume
   mysql-data
        ↓
Docker Engine
        ↓
MySQL Container
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

| Feature            | Docker Volumes | Bind Mounts     |
| ------------------ | -------------- | --------------- |
| Managed by Docker  | Yes            | No              |
| Portability        | Better         | Limited         |
| Security           | Better         | Lower           |
| Backup Friendly    | Yes            | Manual          |
| OS Independent     | Yes            | No              |
| Performance        | Better         | Depends on host |
| Recommended for DB | Yes            | Not ideal       |
| Easy Sharing       | Yes            | Limited         |

---

# Why Enterprises Prefer Volumes

Volumes:

* work better with Kubernetes
* easier for backups
* easier for migration
* safer for production databases
* Stateful containers
* Production apps

Volumes provide:

```text id="q4v7lm"
Better reliability and portability
```

---

# 5. Lifecycle of Docker Volumes

## Step-by-Step Lifecycle

---

## Step 1 — Create Volume

```bash id="m7x1pc"
docker volume create app-data
```

---

## Step 2 — Attach to Container

```bash id="k3n8zw"
docker run -d \
-v app-data:/app/data nginx
```

---

## Step 3 — Application Writes Data

```text id="w5r2tb"
Container writes files
into mounted volume
```

---

## Step 4 — Container Removed

```bash id="x8m4qv"
docker rm -f container1
```

Data:

```text id="p9t1yr"
Still Exists
```

---

## Step 5 — Reattach Volume

```bash id="d2v6kc"
docker run -d \
-v app-data:/app/data nginx
```

Old data becomes available again.

---

# Lifecycle Diagram

```text id="e6w9ns"
Create Volume
      ↓
Attach Volume
      ↓
Store Data(Container Uses Volume)
      ↓
Delete Container
      ↓
Volume Remains(Volume Still Exists)
      ↓
Reuse Volume
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

## Using `-v`

```bash id="t1m6qw"
docker run -d \
-v myvolume:/data \
nginx
```

```bash id="m8q2vt"
docker run -d \
-v app-data:/app/data \
nginx
```

---

# Using `--mount` (Recommended)

```bash id="j9w4py"
docker run -d \
--mount source=myvolume,target=/data \
nginx
```

---

# Difference

| Method  | Description                 |
| ------- | --------------------------- |
| -v      | Short syntax                |
| --mount | Clear & production-friendly |

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

# Enterprise Architecture Example

```text id="z7k5tp"
Users
   ↓
Web Application Container
   ↓
Database Container
   ↓
Docker Volume
   ↓
Persistent Data Storage
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
| Nexus         | Artifact storage       |

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

# Important Interview Points

| Question                   | Answer                                     |
| -------------------------- | ------------------------------------------ |
| Why Volumes?               | To persist data beyond container lifecycle |
| Why not container storage? | Containers are ephemeral                   |
| Volume vs Bind Mount?      | Volumes are Docker-managed & portable      |
| Recommended for DB?        | Docker Volumes                             |
| Where volumes stored?      | Docker host filesystem                     |

---

# Complete Storage Design

```text id="m8r3qx"
Docker Host
 ├── Containers
 ├── Networks
 └── Volumes
        ↓
Persistent Application Data
```

---

# 13. Interview Short Summary

```text id="c7w4zn"
Docker volumes provide persistent, Docker-managed storage that survives container deletion, while bind mounts directly map host directories into containers. Volumes are preferred in production because they are portable, secure, and easier to manage.
```

