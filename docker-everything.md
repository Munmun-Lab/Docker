```markdown
# 🐳 Docker Commands — Full Production Reference

---

# 📦 Container Management

* Run container: Run container in background with auto-restart
  `docker container run --name <name> --detach --restart always --publish <host>:<container> <image>:<tag>`

* Stop container: Gracefully stop a running container
  `docker container stop <container_id_or_name>`

* Start container: Start a stopped container
  `docker container start <container_id_or_name>`

* Restart container: Restart container with 10-second grace period
  `docker container restart --time 10 <container_id_or_name>`

* Remove container: Force remove container along with volumes
  `docker container rm --force --volumes <container_id_or_name>`

* List containers: List all containers (running + stopped)
  `docker container ls --all`

* Inspect container: Show full container details in JSON format
  `docker container inspect <container_id_or_name>`

* Logs: View live logs with timestamps
  `docker container logs --follow --timestamps --tail 100 <container_id_or_name>`

* Exec: Open interactive shell inside container
  `docker container exec --interactive --tty <container_id_or_name> /bin/bash`

* Stats: Show CPU and memory usage snapshot
  `docker container stats --no-stream`

* Copy file: Copy file from container to host machine
  `docker container cp <container>:/path/to/file /host/path/`

* Prune: Remove stopped containers older than 24 hours
  `docker container prune --force --filter "until=24h"`

---

# 🖼️ Image Management

- Pull image  
  `docker image pull <registry>/<image>:<tag>`  
  Download image from registry

- Build image  
  `docker image build --file Dockerfile --tag <name>:<tag> .`  
  Build image from Dockerfile

- Tag image  
  `docker image tag <source_image>:<tag> <target_image>:<tag>`  
  Create new image tag

- Push image  
  `docker image push <registry>/<image>:<tag>`  
  Push image to registry

- List images  
  `docker image ls --all`  
  List all images

- Remove image  
  `docker image rm --force <image>:<tag>`  
  Remove image

- Inspect image  
  `docker image inspect <image>:<tag>`  
  Show image details

- Image history  
  `docker image history --no-trunc <image>:<tag>`  
  Show image layers

- Prune images  
  `docker image prune --all --force`  
  Remove unused images

- Save image  
  `docker image save --output backup.tar <image>:<tag>`  
  Save image as tar file

- Load image  
  `docker image load --input backup.tar`  
  Load image from tar file

---

# 🔊 Volume Management

- Create volume  
  `docker volume create --name <volume_name>`  
  Create named volume

- List volumes  
  `docker volume ls`  
  List all volumes

- Inspect volume  
  `docker volume inspect <volume_name>`  
  Show volume details

- Remove volume  
  `docker volume rm <volume_name>`  
  Remove volume

- Prune volumes  
  `docker volume prune --force`  
  Remove unused volumes

---

# 🌐 Network Management

- Create network  
  `docker network create --driver bridge <network_name>`  
  Create custom bridge network

- List networks  
  `docker network ls`  
  List all networks

- Inspect network  
  `docker network inspect <network_name>`  
  Show network details

- Connect container  
  `docker network connect <network_name> <container_name>`  
  Connect container to network

- Disconnect container  
  `docker network disconnect <network_name> <container_name>`  
  Disconnect container from network

- Remove network  
  `docker network rm <network_name>`  
  Remove network

- Prune networks  
  `docker network prune --force`  
  Remove unused networks

---

# 🐝 Docker Swarm

- Initialize swarm  
  `docker swarm init --advertise-addr <manager_ip>`  
  Initialize swarm manager

- Join worker node  
  `docker swarm join --token <worker_token> <manager_ip>:2377`  
  Add worker node

- Join manager node  
  `docker swarm join --token <manager_token> <manager_ip>:2377`  
  Add manager node

- Get worker token  
  `docker swarm join-token worker`  
  Display worker token

- Deploy stack  
  `docker stack deploy --compose-file docker-compose.yml <stack_name>`  
  Deploy application stack

- List stacks  
  `docker stack ls`  
  List stacks

- List stack services  
  `docker stack services <stack_name>`  
  Show services inside stack

- Remove stack  
  `docker stack rm <stack_name>`  
  Remove stack

- List swarm nodes  
  `docker node ls`  
  Show swarm nodes

- Drain node  
  `docker node update --availability drain <node_id>`  
  Drain workloads from node

---

# ⚙️ Service Management

- Create service  
  `docker service create --name <name> --replicas 3 <image>:<tag>`  
  Create replicated service

- List services  
  `docker service ls`  
  Show services

- Service logs  
  `docker service logs --follow <service_name>`  
  View service logs

- Scale service  
  `docker service scale <service_name>=5`  
  Scale replicas

- Update service  
  `docker service update --image <image>:<tag> <service_name>`  
  Rolling update

- Rollback service  
  `docker service rollback <service_name>`  
  Rollback previous deployment

- Inspect service  
  `docker service inspect --pretty <service_name>`  
  Service details

- Remove service  
  `docker service rm <service_name>`  
  Remove service

---

# 🔐 Secrets & Configs

- Create secret  
  `echo "mypassword" | docker secret create db_password -`  
  Create Docker secret

- Create secret from file  
  `docker secret create <secret_name> /path/secret.txt`  
  Create secret using file

- List secrets  
  `docker secret ls`  
  Show secrets

- Inspect secret  
  `docker secret inspect <secret_name>`  
  Secret details

- Remove secret  
  `docker secret rm <secret_name>`  
  Remove secret

- Create config  
  `docker config create <config_name> config.yml`  
  Create config

- List configs  
  `docker config ls`  
  List configs

---

# 📊 System & Maintenance

- System info  
  `docker system info`  
  Show Docker system information

- Disk usage  
  `docker system df --verbose`  
  Detailed storage usage

- Full prune  
  `docker system prune --all --force --volumes`  
  Remove unused Docker resources

- Docker events  
  `docker system events`  
  View live Docker events

- Login to registry  
  `docker login <registry_url>`  
  Authenticate to registry

- Logout from registry  
  `docker logout <registry_url>`  
  Logout from registry

---

# ⚠️ Production Best Practices

- Always use fixed image tags instead of `latest`
- Use restart policies like `--restart always`
- Prefer named volumes over bind mounts
- Use Docker secrets for passwords
- Run containers as non-root users
- Apply CPU and memory limits
- Use health checks
- Monitor logs regularly
- Scan images for vulnerabilities

---

# 🧠 Simple Docker Workflow

1. Write Dockerfile  
2. Build Docker image  
3. Push image to registry  
4. Pull image from registry  
5. Run container  
6. Monitor and scale application

```
