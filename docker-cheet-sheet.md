# Docker Commands Cheat Sheet

---

# =========================================================
# DOCKER BASIC COMMANDS
# =========================================================

```bash
docker version
docker info
docker help
docker --help
```

---

# =========================================================
# DOCKER IMAGE COMMANDS
# =========================================================

```bash
docker images
docker image ls
docker image inspect <image_name>
docker image history <image_name>
docker image rm <image_name>
docker image prune
docker image prune -a

docker pull ubuntu:22.04
docker pull nginx:latest

docker push <dockerhub_user>/<image_name>:v1

docker tag nginx:latest mynginx:v1
docker tag nginx:latest <dockerhub_user>/nginx:v1

docker save -o nginx.tar nginx:latest
docker load -i nginx.tar

docker import backup.tar myimage:v1
docker export <container_id> > backup.tar

docker search postgres
```

---

# =========================================================
# DOCKER BUILD COMMANDS
# =========================================================

```bash
docker build .
docker build -t myapp:v1 .
docker build -t myapp:latest .

docker build --no-cache -t myapp:v1 .

docker build -f Dockerfile.dev -t myapp:v1 .

docker build --build-arg ENV=prod -t myapp:v1 .

docker buildx build -t myapp:v1 .

docker buildx build --platform linux/amd64 -t myapp:v1 .

docker buildx build --platform linux/arm64 -t myapp:v1 .
```

---

# =========================================================
# DOCKER CONTAINER COMMANDS
# =========================================================

```bash
docker ps
docker ps -a

docker container ls
docker container ls -a

docker run nginx

docker run ubuntu:22.04

docker run -it ubuntu:22.04 /bin/bash

docker run -it alpine sh

docker run -d nginx

docker run -d nginx:latest

docker run --name web nginx

docker run --name postgres postgres:15

docker run --rm ubuntu:22.04

docker run -p 80:80 nginx

docker run -p 8080:80 nginx

docker run -p 5432:5432 postgres:15

docker run -P nginx

docker run -d --name webserver nginx:latest

docker run -d --restart always nginx

docker run -d --restart unless-stopped nginx

docker run -d --restart on-failure nginx

docker run -e MYSQL_ROOT_PASSWORD=password mysql:8

docker run -e POSTGRES_PASSWORD=password postgres:15

docker run --env APP_ENV=prod nginx

docker run -v /host/path:/container/path nginx

docker run -v data_volume:/var/lib/mysql mysql:8

docker run --mount source=myvolume,target=/app nginx

docker run --cpus="2" nginx

docker run --memory="512m" nginx

docker run --memory="1g" --cpus="1.5" nginx

docker run --hostname myhost ubuntu

docker run --dns 8.8.8.8 ubuntu

docker run --privileged ubuntu

docker run --read-only nginx

docker run -it --rm ubuntu bash

docker run -dit ubuntu

docker run -d -p 8080:80 --name web nginx

docker create nginx

docker start <container_id>

docker stop <container_id>

docker restart <container_id>

docker pause <container_id>

docker unpause <container_id>

docker kill <container_id>

docker wait <container_id>

docker rename old_container new_container

docker rm <container_id>

docker rm -f <container_id>

docker container prune
```

---

# =========================================================
# DOCKER EXEC / ATTACH / LOGS
# =========================================================

```bash
docker exec -it <container_id> bash

docker exec -it <container_id> sh

docker exec <container_id> ls

docker exec -u root -it <container_id> bash

docker attach <container_id>

docker logs <container_id>

docker logs -f <container_id>

docker logs --tail 100 <container_id>

docker logs -f --tail 50 <container_id>

docker top <container_id>

docker stats

docker stats <container_id>
```

---

# =========================================================
# DOCKER COPY COMMANDS
# =========================================================

```bash
docker cp file.txt <container_id>:/tmp/

docker cp <container_id>:/tmp/file.txt .

docker cp folder/ <container_id>:/app/
```

---

# =========================================================
# DOCKER NETWORK COMMANDS
# =========================================================

```bash
docker network ls

docker network inspect bridge

docker network create mynetwork

docker network create --driver bridge mynetwork

docker network create --subnet=172.18.0.0/16 mynetwork

docker network connect mynetwork <container_id>

docker network disconnect mynetwork <container_id>

docker network rm mynetwork

docker network prune

docker run --network=mynetwork nginx

docker run --network bridge nginx

docker run --network host nginx

docker run --network none nginx

docker run -d --net=mynetwork --name postgres postgres:15

docker run -d --network=mynetwork --name postgres postgres:15

docker run --network="host" nginx

docker run --network="host" ubuntu ping google.com

docker run -d --network=mynetwork --name app myapp:v1

docker run -it --network=mynetwork ubuntu bash

docker run -d --net=host nginx

docker run -d --net=bridge nginx

docker run -d --net=none nginx
```

---

# =========================================================
# DOCKER VOLUME COMMANDS
# =========================================================

```bash
docker volume ls

docker volume create myvolume

docker volume inspect myvolume

docker volume rm myvolume

docker volume prune

docker run -v myvolume:/data nginx

docker run -v $(pwd):/app ubuntu

docker run -v /opt/data:/var/lib/mysql mysql:8

docker run --mount type=volume,source=myvolume,target=/data nginx

docker run --mount type=bind,source=/host/path,target=/container/path nginx
```

---

# =========================================================
# DOCKER SYSTEM COMMANDS
# =========================================================

```bash
docker system df

docker system prune

docker system prune -a

docker system prune -a --volumes

docker inspect <container_id>

docker inspect nginx

docker events

docker diff <container_id>
```

---

# =========================================================
# DOCKER LOGIN / REGISTRY COMMANDS
# =========================================================

```bash
docker login

docker logout

docker login docker.io

docker login <private_registry>

docker tag myapp:v1 <dockerhub_user>/myapp:v1

docker push <dockerhub_user>/myapp:v1

docker pull <dockerhub_user>/myapp:v1
```

---

# =========================================================
# DOCKER COMPOSE COMMANDS
# =========================================================

```bash
docker compose version

docker compose up

docker compose up -d

docker compose down

docker compose start

docker compose stop

docker compose restart

docker compose ps

docker compose logs

docker compose logs -f

docker compose pull

docker compose build

docker compose exec web bash

docker compose exec db psql -U postgres

docker compose config

docker-compose up -d

docker-compose down

docker-compose ps

docker-compose logs -f
```

---

# =========================================================
# DOCKER SWARM COMMANDS
# =========================================================

```bash
docker swarm init

docker swarm join --token <token> <manager_ip>:2377

docker swarm leave

docker swarm leave --force

docker node ls

docker node inspect <node_id>

docker service create nginx

docker service ls

docker service ps <service_name>

docker service inspect <service_name>

docker service rm <service_name>

docker stack deploy -c docker-compose.yml mystack

docker stack ls

docker stack services mystack

docker stack rm mystack
```

---

# =========================================================
# DOCKER RESOURCE CLEANUP COMMANDS
# =========================================================

```bash
docker rm $(docker ps -aq)

docker rmi $(docker images -q)

docker stop $(docker ps -aq)

docker system prune -f

docker image prune -f

docker container prune -f

docker volume prune -f

docker network prune -f
```

---

# =========================================================
# DOCKER INSPECTION & DEBUGGING COMMANDS
# =========================================================

```bash
docker inspect <container_id>

docker inspect <image_name>

docker port <container_id>

docker history <image_name>

docker stats

docker events

docker exec -it <container_id> env

docker exec -it <container_id> cat /etc/os-release
```

---

# =========================================================
# DOCKERFILE RELATED COMMANDS
# =========================================================

```dockerfile
FROM ubuntu:22.04

RUN apt update

RUN apt install -y nginx

COPY . /app

ADD file.tar.gz /app

WORKDIR /app

ENV APP_ENV=prod

EXPOSE 80

CMD ["nginx","-g","daemon off;"]

ENTRYPOINT ["python"]

LABEL version="1.0"

USER appuser

VOLUME ["/data"]
```

---

# =========================================================
# USEFUL REAL-TIME EXAMPLES
# =========================================================

```bash
docker run -d -p 80:80 --name nginx-server nginx:latest

docker run -it --rm ubuntu:22.04 bash

docker run -d \
  --name postgres-db \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  postgres:15

docker run -d \
  --network=mynetwork \
  --name app-container \
  myapp:v1

docker run -d \
  --net=mynetwork \
  --name postgres \
  training/postgres

docker run --network="host" nginx

docker run --network="host" ubuntu ping google.com

docker exec -it nginx-server bash

docker logs -f nginx-server

docker build -t myapp:v1 .

docker tag myapp:v1 <dockerhub_user>/myapp:v1

docker push <dockerhub_user>/myapp:v1
```

---


# =========================================================
# MOST COMMONLY USED DOCKER FLAGS
# =========================================================

| Flag | Meaning |
|------|----------|
| `-d` | Run container in detached/background mode |
| `-it` | Interactive terminal |
| `--rm` | Remove container automatically after exit |
| `-p` | Port mapping |
| `-P` | Random port mapping |
| `-v` | Mount volume |
| `--mount` | Advanced storage mount |
| `--name` | Assign container name |
| `-e` | Environment variable |
| `--network` | Connect to Docker network |
| `--net` | Short form of network |
| `--restart` | Restart policy |
| `--cpus` | CPU limit |
| `--memory` | Memory limit |
| `--privileged` | Extended container privileges |
| `--dns` | Custom DNS |
| `--hostname` | Custom hostname |
| `--read-only` | Read-only filesystem |
| `--build-arg` | Build argument |
| `-f` | Specify Dockerfile |
| `-t` | Tag image |
| `-i` | Interactive input |
