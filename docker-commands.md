# Docker Common Docker Commands

| Command                     | Purpose                                 |
| --------------------------- | --------------------------------------- |
| `docker version`            | Show Docker version                     |
| `docker info`               | Display Docker system information       |
| `docker images`             | List Docker images                      |
| `docker image ls`           | List images                             |
| `docker image inspect`      | Show image details                      |
| `docker image rm`           | Remove image                            |
| `docker build`              | Build image from Dockerfile             |
| `docker pull`               | Download image from registry            |
| `docker push`               | Upload image to registry                |
| `docker search`             | Search images from Docker Hub           |
| `docker login`              | Login to Docker registry                |
| `docker logout`             | Logout from Docker registry             |
| `docker tag`                | Tag/rename image                        |
| `docker history`            | Show image layer history                |
| `docker save`               | Save image as tar file                  |
| `docker load`               | Load image from tar file                |
| `docker run`                | Create and run container                |
| `docker create`             | Create container without starting       |
| `docker start`              | Start stopped container                 |
| `docker stop`               | Stop running container                  |
| `docker restart`            | Restart container                       |
| `docker pause`              | Pause container processes               |
| `docker unpause`            | Resume paused container                 |
| `docker kill`               | Force stop container                    |
| `docker ps`                 | List running containers                 |
| `docker ps -a`              | List all containers                     |
| `docker inspect`            | Show container details                  |
| `docker logs`               | View container logs                     |
| `docker top`                | Show running processes inside container |
| `docker stats`              | Show CPU/memory/network usage           |
| `docker exec`               | Run command inside running container    |
| `docker attach`             | Attach terminal to running container    |
| `docker cp`                 | Copy files between host and container   |
| `docker rename`             | Rename container                        |
| `docker update`             | Update container resources              |
| `docker wait`               | Wait for container to stop              |
| `docker port`               | Show mapped ports                       |
| `docker rm`                 | Remove container                        |
| `docker container prune`    | Remove stopped containers               |
| `docker rmi`                | Remove Docker image                     |
| `docker system df`          | Show Docker disk usage                  |
| `docker system prune`       | Remove unused Docker objects            |
| `docker events`             | Show real-time Docker events            |
| `docker diff`               | Show file changes in container          |
| `docker commit`             | Create image from running container     |
| `docker export`             | Export container filesystem             |
| `docker import`             | Import filesystem as image              |
| `docker volume create`      | Create volume                           |
| `docker volume ls`          | List volumes                            |
| `docker volume inspect`     | Show volume details                     |
| `docker volume rm`          | Remove volume                           |
| `docker volume prune`       | Remove unused volumes                   |
| `docker network create`     | Create network                          |
| `docker network ls`         | List networks                           |
| `docker network inspect`    | Show network details                    |
| `docker network connect`    | Connect container to network            |
| `docker network disconnect` | Disconnect container from network       |
| `docker network rm`         | Remove network                          |
| `docker network prune`      | Remove unused networks                  |
| `docker compose up`         | Start multi-container application       |
| `docker compose down`       | Stop and remove compose application     |
| `docker compose ps`         | List compose containers                 |
| `docker compose logs`       | View compose logs                       |
| `docker compose build`      | Build compose services                  |
| `docker compose pull`       | Pull compose images                     |
| `docker compose restart`    | Restart compose services                |
| `docker compose exec`       | Execute command in compose container    |
| `docker compose config`     | Validate compose file                   |
| `docker builder prune`      | Remove build cache                      |
| `docker context ls`         | List Docker contexts                    |
| `docker context use`        | Switch Docker context                   |
| `docker plugin ls`          | List plugins                            |
| `docker secret ls`          | List Docker secrets (Swarm)             |
| `docker service ls`         | List Docker services (Swarm)            |
| `docker stack ls`           | List Docker stacks                      |
| `docker node ls`            | List swarm nodes                        |
| `docker swarm init`         | Initialize Docker Swarm                 |
| `docker swarm join`         | Join Docker Swarm cluster               |

---

# Frequently Used Docker Run Options

| Option      | Purpose                     |
| ----------- | --------------------------- |
| `-d`        | Run container in background |
| `-it`       | Interactive terminal        |
| `-p`        | Port mapping                |
| `-v`        | Volume mount                |
| `--mount`   | Advanced mount syntax       |
| `--name`    | Assign container name       |
| `--rm`      | Auto-remove container       |
| `-e`        | Set environment variable    |
| `--network` | Connect to network          |
| `--cpus`    | Limit CPU                   |
| `--memory`  | Limit RAM                   |
| `--restart` | Restart policy              |

---

# Important Docker Categories

| Category   | Commands                       |
| ---------- | ------------------------------ |
| Images     | build, pull, push, images, rmi |
| Containers | run, ps, stop, rm, logs        |
| Volumes    | volume create, ls, rm          |
| Networks   | network create, inspect        |
| Compose    | compose up, down               |
| Monitoring | stats, logs, events            |
| Cleanup    | prune commands                 |
| Swarm      | service, stack, node           |

---

# Most Important Commands for Interviews

```bash id="g5w9tr"
docker build
docker run
docker ps
docker logs
docker exec
docker images
docker pull
docker push
docker stop
docker rm
docker stats
docker volume ls
docker network ls
docker compose up
docker system prune
```
