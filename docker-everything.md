````markdown id="jlwm4m"
# 🐳 Docker Commands — Full Production Reference

---

# 📦 Container Management

Docker container commands are used to create, manage, monitor, and remove containers.

- Run container  
  ```bash
  docker container run --name <name> --detach --restart always --publish <host>:<container> <image>:<tag>
  ```

- Stop container  
  ```bash
  docker container stop <container_id_or_name>
  ```

- Start container  
  ```bash
  docker container start <container_id_or_name>
  ```

- Restart container  
  ```bash
  docker container restart --time 10 <container_id_or_name>
  ```

- Remove container  
  ```bash
  docker container rm --force --volumes <container_id_or_name>
  ```

- List containers  
  ```bash
  docker container ls --all
  ```

- Inspect container  
  ```bash
  docker container inspect <container_id_or_name>
  ```

- Container logs  
  ```bash
  docker container logs --follow --timestamps --tail 100 <container_id_or_name>
  ```

- Exec into container  
  ```bash
  docker container exec --interactive --tty <container_id_or_name> /bin/bash
  ```

- Container stats  
  ```bash
  docker container stats --no-stream
  ```

- Copy file  
  ```bash
  docker container cp <container>:/path/to/file /host/path/
  ```

- Prune stopped containers  
  ```bash
  docker container prune --force
  ```

---

# 🖼️ Image Management

Docker image commands are used to build, download, upload, and manage images.

- Pull image  
  ```bash
  docker image pull <registry>/<image>:<tag>
  ```

- Build image  
  ```bash
  docker image build --file Dockerfile --tag <name>:<tag> .
  ```

- Tag image  
  ```bash
  docker image tag <source_image>:<tag> <registry>/<image>:<tag>
  ```

- Push image  
  ```bash
  docker image push <registry>/<image>:<tag>
  ```

- List images  
  ```bash
  docker image ls --all
  ```

- Remove image  
  ```bash
  docker image rm --force <image_id_or_name>:<tag>
  ```

- Inspect image  
  ```bash
  docker image inspect <image>:<tag>
  ```

- Image history  
  ```bash
  docker image history --no-trunc <image>:<tag>
  ```

- Prune images  
  ```bash
  docker image prune --all --force
  ```

- Save image  
  ```bash
  docker image save --output /backup/<image>.tar <image>:<tag>
  ```

- Load image  
  ```bash
  docker image load --input /backup/<image>.tar
  ```

---

# 🔊 Volume Management

Docker volumes provide persistent storage for containers.

- Create volume  
  ```bash
  docker volume create --name <volume_name>
  ```

- List volumes  
  ```bash
  docker volume ls
  ```

- Inspect volume  
  ```bash
  docker volume inspect <volume_name>
  ```

- Remove volume  
  ```bash
  docker volume rm <volume_name>
  ```

- Prune volumes  
  ```bash
  docker volume prune --force
  ```

---

# 🌐 Network Management

Docker networks allow containers to communicate securely.

- Create network  
  ```bash
  docker network create --driver bridge <network_name>
  ```

- List networks  
  ```bash
  docker network ls
  ```

- Inspect network  
  ```bash
  docker network inspect <network_name>
  ```

- Connect container  
  ```bash
  docker network connect <network_name> <container_name>
  ```

- Disconnect container  
  ```bash
  docker network disconnect <network_name> <container_name>
  ```

- Remove network  
  ```bash
  docker network rm <network_name>
  ```

- Prune networks  
  ```bash
  docker network prune --force
  ```

---

# 🐝 Docker Swarm

Docker Swarm is Docker’s native orchestration platform.

- Initialize Swarm  
  ```bash
  docker swarm init --advertise-addr <manager_ip>
  ```

- Join as worker  
  ```bash
  docker swarm join --token <worker_token> <manager_ip>:2377
  ```

- Join as manager  
  ```bash
  docker swarm join --token <manager_token> <manager_ip>:2377
  ```

- Get worker token  
  ```bash
  docker swarm join-token worker
  ```

- Deploy stack  
  ```bash
  docker stack deploy --compose-file docker-compose.yml <stack_name>
  ```

- List stacks  
  ```bash
  docker stack ls
  ```

- Stack services  
  ```bash
  docker stack services <stack_name>
  ```

- Remove stack  
  ```bash
  docker stack rm <stack_name>
  ```

- List nodes  
  ```bash
  docker node ls
  ```

- Drain node  
  ```bash
  docker node update --availability drain <node_id>
  ```

---

# ⚙️ Service Management

Docker services manage workloads inside Swarm.

- Create service  
  ```bash
  docker service create --name <name> --replicas 3 <image>:<tag>
  ```

- List services  
  ```bash
  docker service ls
  ```

- Service logs  
  ```bash
  docker service logs --follow <service_name>
  ```

- Scale service  
  ```bash
  docker service scale <service_name>=5
  ```

- Update service  
  ```bash
  docker service update --image <image>:<new_tag> <service_name>
  ```

- Rollback service  
  ```bash
  docker service rollback <service_name>
  ```

- Inspect service  
  ```bash
  docker service inspect --pretty <service_name>
  ```

- Remove service  
  ```bash
  docker service rm <service_name>
  ```

---

# 🔐 Secrets & Configs

Docker secrets securely manage sensitive data.

- Create secret  
  ```bash
  echo "mysecretvalue" | docker secret create <secret_name> -
  ```

- Create secret from file  
  ```bash
  docker secret create <secret_name> /path/to/secret.txt
  ```

- List secrets  
  ```bash
  docker secret ls
  ```

- Inspect secret  
  ```bash
  docker secret inspect <secret_name>
  ```

- Remove secret  
  ```bash
  docker secret rm <secret_name>
  ```

- Create config  
  ```bash
  docker config create <config_name> /path/to/config.yml
  ```

- List configs  
  ```bash
  docker config ls
  ```

---

# 📊 System & Maintenance

Docker system commands help monitor and clean resources.

- System info  
  ```bash
  docker system info
  ```

- Disk usage  
  ```bash
  docker system df --verbose
  ```

- Full prune  
  ```bash
  docker system prune --all --force --volumes
  ```

- Events  
  ```bash
  docker system events
  ```

- Login to registry  
  ```bash
  docker login <registry_url>
  ```

- Logout from registry  
  ```bash
  docker logout <registry_url>
  ```

---

# ⚠️ Production Best Practices

- Always use fixed image tags instead of `latest`
- Use restart policies like:
  ```bash
  --restart always
  ```

- Use named volumes for persistent storage
- Use Docker secrets for passwords
- Run containers as non-root users
- Apply CPU and memory limits:
  ```bash
  --memory 512m --cpus 1.5
  ```

- Monitor logs regularly
- Scan images for vulnerabilities
- Use health checks for applications

---

# 🧠 Simple Docker Workflow

1. Write Dockerfile
2. Build Docker Image
3. Push Image to Registry
4. Pull Image
5. Run Container
6. Monitor and Scale

---

# 🏗️ Real-Life Docker Analogy

- Dockerfile → Recipe
- Image → Cake template
- Container → Actual cake
- Registry → App store
- Volume → External hard disk
- Network → Wi-Fi/router
- Docker Daemon → Engine
- Docker Client → Remote control

````
