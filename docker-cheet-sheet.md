````md
# 🐳 Docker Commands Cheat Sheet

Simple Docker commands for learning, documentation, and quick reference.

---

# 🔹 Docker Basics

```bash
docker version
docker info
docker help
docker --help
```

---

# 🔹 Docker Images

```bash
docker images
docker image ls
docker pull nginx:latest
docker pull ubuntu:22.04

docker build -t myapp:v1 .
docker build --no-cache -t myapp:v1 .

docker tag nginx:latest mynginx:v1
docker push <dockerhub_user>/myapp:v1

docker image inspect nginx
docker image history nginx

docker rmi nginx
docker image prune -a
```

---

# 🔹 Docker Containers

```bash
docker ps
docker ps -a

docker run nginx
docker run -d nginx
docker run -it ubuntu:22.04 bash

docker run --name web nginx
docker run --rm ubuntu bash

docker stop <container_id>
docker start <container_id>
docker restart <container_id>
docker kill <container_id>

docker rm <container_id>
docker rm -f <container_id>
```

---

# 🔹 Port Mapping

```bash
docker run -p 80:80 nginx
docker run -p 8080:80 nginx

docker run -d -p 5432:5432 postgres:15
```

---

# 🔹 Interactive Mode

```bash
docker run -it ubuntu bash
docker exec -it <container_id> bash
docker exec -it <container_id> sh
```

---

# 🔹 Background Mode

```bash
docker run -d nginx
docker run -dit ubuntu
```

---

# 🔹 Environment Variables

```bash
docker run -e MYSQL_ROOT_PASSWORD=password mysql:8
docker run -e POSTGRES_PASSWORD=password postgres:15

docker run --env APP_ENV=prod nginx
```

---

# 🔹 Docker Volumes

```bash
docker volume ls
docker volume create myvolume

docker run -v myvolume:/data nginx

docker run -v /host/path:/container/path nginx

docker run --mount type=volume,source=myvolume,target=/data nginx
```

---

# 🔹 Docker Networks

```bash
docker network ls

docker network create mynetwork

docker network inspect bridge

docker network rm mynetwork
```

---

# 🔹 Run Container with Network

```bash
docker run --network=mynetwork nginx

docker run -d \
  --network=mynetwork \
  --name postgres \
  postgres:15
```

---

# 🔹 Host Network Examples

```bash
docker run --network="host" nginx

docker run --network="host" ubuntu ping google.com

docker run -d --net=host nginx
```

---

# 🔹 Bridge / None Network

```bash
docker run --net=bridge nginx

docker run --net=none nginx
```

---

# 🔹 Docker Logs & Monitoring

```bash
docker logs <container_id>

docker logs -f <container_id>

docker stats

docker top <container_id>
```

---

# 🔹 Copy Files

```bash
docker cp file.txt <container_id>:/tmp/

docker cp <container_id>:/tmp/file.txt .
```

---

# 🔹 Docker Inspect & Debug

```bash
docker inspect <container_id>

docker port <container_id>

docker events

docker diff <container_id>
```

---

# 🔹 Docker Cleanup

```bash
docker system prune -f

docker image prune -f

docker container prune -f

docker volume prune -f

docker network prune -f
```

---

# 🔹 Docker Login & Registry

```bash
docker login

docker logout

docker push <dockerhub_user>/myapp:v1

docker pull <dockerhub_user>/myapp:v1
```

---

# 🔹 Docker Compose

```bash
docker compose up -d

docker compose down

docker compose ps

docker compose logs -f

docker compose build
```

---

# 🔹 Docker Swarm

```bash
docker swarm init

docker node ls

docker service create nginx

docker service ls

docker stack deploy -c docker-compose.yml mystack
```

---

# 🔹 Useful Real-Time Examples

## Run Nginx

```bash
docker run -d -p 80:80 --name nginx-server nginx:latest
```

## Run PostgreSQL

```bash
docker run -d \
  --name postgres-db \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  postgres:15
```

## Run with Custom Network

```bash
docker run -d \
  --network=mynetwork \
  --name app-container \
  myapp:v1
```

## Access Container Shell

```bash
docker exec -it nginx-server bash
```

## View Logs

```bash
docker logs -f nginx-server
```

---

# 🔹 Dockerfile Basics

```dockerfile
FROM ubuntu:22.04

RUN apt update

RUN apt install -y nginx

COPY . /app

WORKDIR /app

ENV APP_ENV=prod

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
```

---

# 🚀 Quick Remember Commands

```bash
docker ps
docker images
docker pull nginx
docker build -t app:v1 .
docker run -d -p 80:80 nginx
docker exec -it <container_id> bash
docker logs -f <container_id>
docker stop <container_id>
docker rm <container_id>
docker rmi nginx
docker compose up -d
docker system prune -f
```
````
