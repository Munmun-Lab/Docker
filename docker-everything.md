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

## 🖼️ Image Management

Pull image: Pull specific tagged image
docker image pull `<registry>/<image>:<tag>`

Build image: Build image with no cache and build arguments
docker image build --file Dockerfile --tag `<name>:<tag>` --no-cache --build-arg ENV=prod .

Tag image: Tag image for registry push
docker image tag `<source_image>:<tag>` `<registry>/<image>:<tag>`

Push image: Push image to registry
docker image push `<registry>/<image>:<tag>`

List images: List all images
docker image ls --all

Remove image: Force remove image
docker image rm --force `<image_id_or_name>:<tag>`

Inspect image: Show image configuration details
docker image inspect `<image>:<tag>`

Image history: Show full layer history
docker image history --no-trunc `<image>:<tag>`

Prune images: Remove unused images older than 72 hours
docker image prune --all --force --filter "until=72h"

Save image: Save image to tar file
docker image save --output /backup/<image>.tar `<image>:<tag>`

Load image: Load image from tar file
docker image load --input /backup/<image>.tar

---

## 🔊 Volume Management

Create volume: Create a named volume
docker volume create --name `<volume_name>`

List volumes: List all volumes
docker volume ls

Inspect volume: Show volume details
docker volume inspect `<volume_name>`

Remove volume: Remove a volume
docker volume rm `<volume_name>`

Prune volumes: Remove unused volumes
docker volume prune --force --filter "label!=keep"

---

## 🌐 Network Management

Create network: Create custom bridge network
docker network create --driver bridge --subnet 172.20.0.0/16 `<network_name>`

List networks: List all networks
docker network ls

Inspect network: Show full network details
docker network inspect `<network_name>`

Connect container: Connect container to network
docker network connect `<network_name>` `<container_name>`

Disconnect container: Remove container from network
docker network disconnect --force `<network_name>` `<container_name>`

Remove network: Remove a network
docker network rm `<network_name>`

Prune networks: Remove unused networks
docker network prune --force

---

## 🐝 Docker Swarm

Init Swarm: Initialize swarm manager
docker swarm init --advertise-addr `<manager_ip>`

Join as Worker: Add worker node to swarm
docker swarm join --token `<worker_token>` `<manager_ip>:2377`

Join as Manager: Add manager node to swarm
docker swarm join --token `<manager_token>` `<manager_ip>:2377`

Get join token: Show worker join token
docker swarm join-token worker

Deploy stack: Deploy application stack
docker stack deploy --compose-file docker-compose.yml `<stack_name>`

List stacks: List all stacks
docker stack ls

Stack services: Show services in stack
docker stack services `<stack_name>`

Remove stack: Remove stack
docker stack rm `<stack_name>`

List nodes: Show swarm nodes
docker node ls

Drain node: Move workloads off node
docker node update --availability drain `<node_id>`

---

## ⚙️ Service Management

Create service: Create replicated service
docker service create --name `<name>` --replicas 3 --publish 80:80 `<image>:<tag>`

List services: List all services
docker service ls

Service logs: View service logs
docker service logs --follow `<service_name>`

Scale service: Scale number of replicas
docker service scale `<service_name>`=5

Update service: Rolling update service image
docker service update --image `<image>:<tag>` `<service_name>`

Rollback service: Rollback to previous version
docker service rollback `<service_name>`

Inspect service: Show service details
docker service inspect --pretty `<service_name>`

Remove service: Delete service
docker service rm `<service_name>`

---

## 🔐 Secrets & Configs

Create secret: Create secret from stdin
echo "value" | docker secret create `<secret_name>` -

Create from file: Create secret from file
docker secret create `<secret_name>` /path/to/file

List secrets: List all secrets
docker secret ls

Inspect secret: Show secret details
docker secret inspect `<secret_name>`

Remove secret: Delete secret
docker secret rm `<secret_name>`

Create config: Create swarm config
docker config create `<config_name>` /path/to/config.yml

List configs: List configs
docker config ls

---

## 📊 System & Maintenance

System info: Show Docker system details
docker system info

Disk usage: Show Docker disk usage
docker system df --verbose

Full prune: Remove all unused resources (⚠️ dangerous)
docker system prune --all --force --volumes --filter "until=48h"

Events: Show Docker events
docker system events --since 1h

Login registry: Login to registry
docker login `<registry_url>`

Logout registry: Logout from registry
docker logout `<registry_url>`

---

If you want next upgrade, I can convert this into:

* 📘 GitHub README.md (perfect formatting)
* 📄 PDF cheat sheet
* 🧠 interview revision sheet (1-page summary)
* ⚡ Linux + Docker combo command sheet


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
