# Docker
Docker related notes, projects, code, etc..
---
# docker image build command

docker build -t monitor-app .  -> Significance of . in last
In this command:

```bash id="m4x8qp"
docker build -t monitor-app .
```

the last `.` (dot) is very important.

It means:

```text id="q7v2nk"
Current directory / current folder
```

# What Docker Does

Docker looks in the current folder for:

* Dockerfile
* application files
* source code
* configs

and sends them as:

```text id="x9r3tk"
Build Context
```

to the Docker daemon.

---

# Simple Understanding

Docker needs:

* Dockerfile
* application files

to build the image.

The `.` tells Docker:

```text id="r3m9tw"
"Use files from this current folder"
```

---

# Example

Suppose you are inside:

```text id="z1k5px"
/home/user/myapp
```

Folder contains:

```text id="c8n4qy"
myapp/
 ├── Dockerfile
 ├── index.html
 └── app.py
```

You go inside:

```bash id="h2m7qn"
cd myapp
```

When you run:

```bash id="w6p2mr"
docker build -t myapp .
```

The `.` means:

```text id="f8p4zm"
Use everything inside current folder
as build context
```

Docker:

* looks inside current folder
* finds Dockerfile
* sends current folder files as build context

---

# Important Concept → Build Context

The `.` represents:

```text id="v2t7kc"
Build Context
```

Meaning:

```text id="x9r1nm"
All files Docker can access during build
```

---

# Visual Flow

```text id="f5m8qx"
Current Folder (.)
      ↓
Docker Build Context
      ↓
Dockerfile Reads Files
      ↓
Docker Image Created
```

---

# Example with COPY

Dockerfile:

```dockerfile id="n4w7tp"
COPY index.html /app/
```

Docker copies:

```text id="p6k2vz"
FROM:
Current folder (.)

TO:
Container image
```

---

# If `.` Is Missing?

Docker won’t know:

* where Dockerfile is
* where application files are

Build fails.

---

# Other Examples

## Build from another folder

```bash id="j3q9nx"
docker build -t app /home/user/project
```

Instead of current folder:

```text id="s7v1mk"
Use /home/user/project as build context
```

---

# Interview Short Answer

```text id="y4n8pr"
The dot (.) in docker build represents the current directory and acts as the Docker build context containing the Dockerfile and application files required to build the image.
```

