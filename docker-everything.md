```markdown
# 🐳 Docker Commands — Full Production Reference

---

# 📦 Container Management

Docker container commands are used to create, manage, monitor, and remove running containers.

| Command | Full Format | Description |
|---|---|---|
| Run container | `docker container run --name <name> --detach --restart always --publish <host>:<container> <image>:<tag>` | Run container in background with auto-restart |
| Stop container | `docker container stop <container_id_or_name>` | Gracefully stop a running container |
| Start container | `docker container start <container_id_or_name>` | Start a stopped container |
| Restart container | `docker container restart --time 10 <container_id_or_name>` | Restart with grace period |
| Remove container | `docker container rm --force --volumes <container_id_or_name>` | Remove container with volumes |
| List containers | `docker container ls --all --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"` | List all containers |
| Inspect container | `docker container inspect --format '{{json .}}' <container>` | Inspect container details |
| Container logs | `docker container logs --follow --timestamps --tail 100 <container>` | View live logs |
| Exec into container | `docker container exec --interactive --tty <container> /bin/bash` | Open shell inside container |
| Container stats | `docker container stats --no-stream` | Resource usage snapshot |
| Copy file | `docker container cp <container>:/path /host/path` | Copy files between host and container |
| Prune stopped | `docker container prune --force` | Remove stopped containers |

---

# 🖼️ Image Management

Docker image commands are used to build, pull, push, inspect, and manage images.

| Command | Full Format | Description |
|---|---|---|
| Pull image | `docker image pull <registry>/<image>:<tag>` | Download image from registry |
| Build image | `docker image build --file Dockerfile --tag <name>:<tag> .` | Build image from Dockerfile |
| Tag image | `docker image tag <source>:<tag> <target>:<tag>` | Create another image tag |
| Push image | `docker image push <registry>/<image>:<tag>` | Push image to registry |
| List images | `docker image ls --all` | List Docker images |
| Remove image | `docker image rm --force <image>:<tag>` | Remove image |
| Inspect image | `docker image inspect <image>:<tag>` | Inspect image details |
| Image history | `docker image history --no-trunc <image>:<tag>` | Show image layers |
| Prune images | `docker image prune --all --force` | Remove unused images |
| Save image | `docker image save --output backup.tar <image>:<tag>` | Save image as tar |
| Load image | `docker image load --input backup.tar` | Load image from tar |

---

# 🔊 Volume Management

Docker volumes are used for persistent storage.

| Command | Full Format | Description |
|---|---|---|
| Create volume | `docker volume create --name <volume_name>` | Create named volume |
| List volumes | `docker volume ls` | List all volumes |
| Inspect volume | `docker volume inspect <volume_name>` | Volume details |
| Remove volume | `docker volume rm <volume_name>` | Remove volume |
| Prune volumes | `docker volume prune --force` | Remove unused volumes |

---

# 🌐 Network Management

Docker networks allow containers to communicate securely.

| Command | Full Format | Description |
|---|---|---|
| Create network | `docker network create --driver bridge <network_name>` | Create custom network |
| List networks | `docker network ls` | List networks |
| Inspect network | `docker network inspect <network_name>` | Inspect network |
| Connect container | `docker network connect <network_name> <container>` | Connect container to network |
| Disconnect container | `docker network disconnect <network_name> <container>` | Disconnect container |
| Remove network | `docker network rm <network_name>` | Remove network |
| Prune networks | `docker network prune --force` | Remove unused networks |

---

# 🐝 Docker Swarm

Docker Swarm is Docker’s native container orchestration platform.

| Command | Full Format | Description |
|---|---|---|
| Init Swarm | `docker swarm init --advertise-addr <manager_ip>` | Initialize swarm |
| Join Worker | `docker swarm join --token <token> <manager_ip>:2377` | Join as worker |
| Join Manager | `docker swarm join --token <token> <manager_ip>:2377` | Join as manager |
| Get token | `docker swarm join-token worker` | Display worker token |
| Deploy stack | `docker stack deploy --compose-file docker-compose.yml <stack>` | Deploy application stack |
| List stacks | `docker stack ls` | List stacks |
| Stack services | `docker stack services <stack>` | List stack services |
| Remove stack | `docker stack rm <stack>` | Remove stack |
| List nodes | `docker node ls` | List swarm nodes |
| Drain node | `docker node update --availability drain <node>` | Drain workloads |

---

# ⚙️ Service Management

Docker services manage replicated workloads inside Swarm.

| Command | Full Format | Description |
|---|---|---|
| Create service | `docker service create --name <name> --replicas 3 <image>:<tag>` | Create service |
| List services | `docker service ls` | List services |
| Service logs | `docker service logs --follow <service>` | View logs |
| Scale service | `docker service scale <service>=5` | Scale replicas |
| Update service | `docker service update --image <image>:<tag> <service>` | Rolling update |
| Rollback service | `docker service rollback <service>` | Rollback update |
| Inspect service | `docker service inspect --pretty <service>` | Service details |
| Remove service | `docker service rm <service>` | Remove service |

---

# 🔐 Secrets & Configs

Docker secrets securely manage passwords and sensitive data.

| Command | Full Format | Description |
|---|---|---|
| Create secret | `echo "mypassword" \| docker secret create db_password -` | Create secret |
| Secret from file | `docker secret create <secret> /path/file.txt` | Create from file |
| List secrets | `docker secret ls` | List secrets |
| Inspect secret | `docker secret inspect <secret>` | Secret details |
| Remove secret | `docker secret rm <secret>` | Remove secret |
| Create config | `docker config create <config> config.yml` | Create config |
| List configs | `docker config ls` | List configs |

---

# 📊 System & Maintenance

Docker system commands help monitor and clean Docker resources.

| Command | Full Format | Description |
|---|---|---|
| System info | `docker system info` | Docker system details |
| Disk usage | `docker system df --verbose` | Storage usage |
| Full prune | `docker system prune --all --force --volumes` | Remove unused resources |
| Events | `docker system events` | Live Docker events |
| Login registry | `docker login <registry_url>` | Login to registry |
| Logout registry | `docker logout <registry_url>` | Logout from registry |

---

# ⚠️ Production Best Practices

| Best Practice | Description |
|---|---|
| Avoid `latest` tag | Always use fixed image versions |
| Use restart policy | `--restart always` for resilience |
| Use named volumes | Better persistent storage |
| Use secrets | Never expose passwords via environment variables |
| Run as non-root | Improve security |
| Apply limits | Use `--memory` and `--cpus` |
| Monitor logs | Use centralized logging |
| Scan images | Check vulnerabilities regularly |
| Use health checks | Monitor container health |

---

# 🧠 Simple Docker Flow

| Step | Action |
|---|---|
| 1 | Write Dockerfile |
| 2 | Build Image |
| 3 | Push Image to Registry |
| 4 | Pull Image |
| 5 | Run Container |
| 6 | Monitor & Scale |

---

# 🏗️ Real-Life Docker Analogy

| Docker Component | Real-Life Example |
|---|---|
| Dockerfile | Recipe |
| Image | Cake template |
| Container | Actual cake |
| Registry | App store |
| Volume | External hard disk |
| Network | Wi-Fi/router |
| Docker Daemon | Engine |
| Docker Client | Remote control |

```
