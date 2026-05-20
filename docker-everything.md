You can directly save this as `docker-production-commands.md`.

````markdown
# 🐳 Docker Commands — Full Production Reference

This document contains commonly used Docker commands in full production-ready format for Containers, Images, Volumes, Networks, Swarm, Services, Secrets, and System Management.

---

# 📦 Container Management

| Command | Full Format | Description |
|---|---|---|
| Run container | `docker container run --name <name> --detach --restart always --publish <host>:<container> <image>:<tag>` | Run container in background with auto restart |
| Stop container | `docker container stop <container_id_or_name>` | Gracefully stop a running container |
| Start container | `docker container start <container_id_or_name>` | Start stopped container |
| Restart container | `docker container restart --time 10 <container_id_or_name>` | Restart with 10-second grace period |
| Remove container | `docker container rm --force --volumes <container_id_or_name>` | Remove container and attached volumes |
| List containers | `docker container ls --all --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"` | List containers in table format |
| Inspect container | `docker container inspect --format '{{json .}}' <container_id_or_name>` | Full container JSON details |
| Container logs | `docker container logs --follow --timestamps --tail 100 <container_id_or_name>` | Stream logs with timestamps |
| Exec into container | `docker container exec --interactive --tty <container_id_or_name> /bin/bash` | Open interactive shell |
| Container stats | `docker container stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"` | View CPU and memory usage |
| Copy file | `docker container cp <container>:/path/to/file /host/path/` | Copy file from container |
| Prune stopped containers | `docker container prune --force --filter "until=24h"` | Remove old stopped containers |

---

# 🖼️ Image Management

| Command | Full Format | Description |
|---|---|---|
| Pull image | `docker image pull <registry>/<image>:<tag>` | Pull image from registry |
| Build image | `docker image build --file Dockerfile --tag <name>:<tag> --no-cache --build-arg ENV=prod .` | Build Docker image |
| Tag image | `docker image tag <source_image>:<tag> <registry>/<image>:<tag>` | Tag image for registry |
| Push image | `docker image push <registry>/<image>:<tag>` | Push image to registry |
| List images | `docker image ls --all --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"` | List all images |
| Remove image | `docker image rm --force <image_id_or_name>:<tag>` | Remove image |
| Inspect image | `docker image inspect --format '{{json .Config}}' <image>:<tag>` | Inspect image configuration |
| Image history | `docker image history --no-trunc <image>:<tag>` | View image layers |
| Prune images | `docker image prune --all --force --filter "until=72h"` | Remove unused images |
| Save image | `docker image save --output /backup/<image>.tar <image>:<tag>` | Save image to tar |
| Load image | `docker image load --input /backup/<image>.tar` | Load image from tar |

---

# 🔊 Volume Management

| Command | Full Format | Description |
|---|---|---|
| Create volume | `docker volume create --driver local --name <volume_name>` | Create Docker volume |
| List volumes | `docker volume ls --format "table {{.Name}}\t{{.Driver}}\t{{.Mountpoint}}"` | List volumes |
| Inspect volume | `docker volume inspect --format '{{json .}}' <volume_name>` | Inspect volume |
| Remove volume | `docker volume rm <volume_name>` | Remove volume |
| Prune volumes | `docker volume prune --force --filter "label!=keep"` | Remove unused volumes |

---

# 🌐 Network Management

| Command | Full Format | Description |
|---|---|---|
| Create network | `docker network create --driver bridge --subnet 172.20.0.0/16 --gateway 172.20.0.1 <network_name>` | Create custom bridge network |
| List networks | `docker network ls --format "table {{.Name}}\t{{.Driver}}\t{{.Scope}}"` | List Docker networks |
| Inspect network | `docker network inspect --format '{{json .}}' <network_name>` | Inspect network |
| Connect container | `docker network connect --alias <alias> <network_name> <container_name>` | Connect container to network |
| Disconnect container | `docker network disconnect --force <network_name> <container_name>` | Disconnect container |
| Remove network | `docker network rm <network_name>` | Remove network |
| Prune networks | `docker network prune --force --filter "until=24h"` | Remove unused networks |

---

# 🐝 Docker Swarm

| Command | Full Format | Description |
|---|---|---|
| Init swarm | `docker swarm init --advertise-addr <manager_ip>` | Initialize swarm |
| Join as worker | `docker swarm join --token <worker_token> <manager_ip>:2377` | Add worker node |
| Join as manager | `docker swarm join --token <manager_token> <manager_ip>:2377` | Add manager node |
| Rotate token | `docker swarm join-token --rotate worker` | Rotate worker token |
| Deploy stack | `docker stack deploy --compose-file docker-compose.yml --with-registry-auth <stack_name>` | Deploy application stack |
| List stacks | `docker stack ls` | List stacks |
| Stack services | `docker stack services <stack_name>` | List services in stack |
| Remove stack | `docker stack rm <stack_name>` | Remove stack |
| List nodes | `docker node ls` | List swarm nodes |
| Drain node | `docker node update --availability drain <node_id>` | Drain workloads from node |

---

# ⚙️ Service Management

| Command | Full Format | Description |
|---|---|---|
| Create service | `docker service create --name <name> --replicas 3 --publish published=80,target=80 --update-delay 10s <image>:<tag>` | Create replicated service |
| List services | `docker service ls --format "table {{.Name}}\t{{.Replicas}}\t{{.Image}}"` | List services |
| Service logs | `docker service logs --follow --timestamps --tail 200 <service_name>` | Stream logs |
| Scale service | `docker service scale <service_name>=5` | Scale replicas |
| Update service | `docker service update --image <image>:<new_tag> --update-parallelism 2 --update-delay 15s <service_name>` | Rolling update |
| Rollback service | `docker service rollback <service_name>` | Rollback service |
| Inspect service | `docker service inspect --pretty <service_name>` | Inspect service |
| Remove service | `docker service rm <service_name>` | Remove service |

---

# 🔐 Secrets & Configs

| Command | Full Format | Description |
|---|---|---|
| Create secret | `echo "mysecretvalue" \| docker secret create <secret_name> -` | Create secret from stdin |
| Create secret from file | `docker secret create <secret_name> /path/to/secret.txt` | Create secret from file |
| List secrets | `docker secret ls --format "table {{.Name}}\t{{.CreatedAt}}"` | List secrets |
| Inspect secret | `docker secret inspect --pretty <secret_name>` | Inspect secret |
| Remove secret | `docker secret rm <secret_name>` | Remove secret |
| Create config | `docker config create <config_name> /path/to/config.yml` | Create config |
| List configs | `docker config ls` | List configs |

---

# 📊 System & Maintenance

| Command | Full Format | Description |
|---|---|---|
| System info | `docker system info --format '{{json .}}'` | Docker system information |
| Disk usage | `docker system df --verbose` | Detailed storage usage |
| Full prune | `docker system prune --all --force --volumes --filter "until=48h"` | Remove unused resources |
| Events | `docker system events --since 1h --filter type=container` | View Docker events |
| Login registry | `docker login <registry_url> --username <user>` | Login to registry |
| Logout registry | `docker logout <registry_url>` | Logout from registry |

---

# ⚠️ Production Best Practices

| Best Practice | Description |
|---|---|
| Use specific tags | Avoid using `latest` in production |
| Restart policy | Use `--restart always` or `on-failure` |
| Use named volumes | Better persistence and management |
| Use secrets | Never expose passwords using `-e` |
| Run as non-root | Use `--user <uid>:<gid>` |
| Set resource limits | Example: `--memory 512m --cpus 1.5` |
| Use health checks | Detect unhealthy containers automatically |
| Enable logging | Use centralized logging solution |
| Scan images | Check vulnerabilities before deployment |
| Use minimal images | Prefer Alpine/slim images |

---

# 📌 Common Production Example

```bash
docker container run \
--name nginx-prod \
--detach \
--restart always \
--publish 80:80 \
--memory 512m \
--cpus 1.5 \
--volume nginx_data:/usr/share/nginx/html \
nginx:stable
```

---
````


