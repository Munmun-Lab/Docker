# 📘 Docker Network Commands Cheat Sheet

# 🔹 List Docker Networks

```bash
docker network ls
```

Example Output:

```text
NETWORK ID     NAME      DRIVER    SCOPE
a1b2c3d4       bridge    bridge    local
e5f6g7h8       host      host      local
i9j0k1l2       none      null      local
```

---

# 🔹 Inspect Network Details

```bash
docker network inspect bridge
```

Inspect custom network:

```bash
docker network inspect my_network
```

Shows:

* Subnet
* Gateway
* Connected containers
* Driver
* IP ranges

---

# 🔹 Create Bridge Network

```bash
docker network create my_bridge
```

Specify driver:

```bash
docker network create \
--driver bridge \
my_bridge
```

---

# 🔹 Create Custom Subnet Network

```bash
docker network create \
--driver bridge \
--subnet 172.20.0.0/16 \
--gateway 172.20.0.1 \
my_secure_net
```

---

# 🔹 Create Internal Network (No Internet Access)

```bash
docker network create \
--internal \
internal_net
```

Use Case:

* Database isolation
* Backend-only communication

---

# 🔹 Create Overlay Network

(Requires Docker Swarm)

Initialize swarm first:

```bash
docker swarm init
```

Create overlay:

```bash
docker network create \
--driver overlay \
my_overlay
```

Attachable overlay:

```bash
docker network create \
--driver overlay \
--attachable \
my_overlay
```

---

# 🔹 Create Host Network

Host network already exists by default.

Use it while running container:

```bash
docker run --network host nginx
```

---

# 🔹 Create Macvlan Network

```bash
docker network create -d macvlan \
--subnet=192.168.1.0/24 \
--gateway=192.168.1.1 \
-o parent=eth0 \
macvlan_net
```

---

# 🔹 Create IPv6 Network

```bash
docker network create \
--ipv6 \
--subnet 2001:db8::/64 \
ipv6_net
```

---

# 🔹 Remove Docker Network

```bash
docker network rm my_network
```

Remove multiple:

```bash
docker network rm net1 net2 net3
```

---

# 🔹 Remove Unused Networks

```bash
docker network prune
```

Force remove:

```bash
docker network prune -f
```

---

# 🔹 Connect Container to Network

```bash
docker network connect my_network container1
```

Example:

```bash
docker network connect backend_net nginx1
```

---

# 🔹 Disconnect Container from Network

```bash
docker network disconnect my_network container1
```

---

# 🔹 Run Container in Specific Network

```bash
docker run -dit \
--name web \
--network my_bridge \
nginx
```

---

# 🔹 Run Container with Static IP

```bash
docker run -dit \
--name app1 \
--network my_bridge \
--ip 172.20.0.10 \
nginx
```

---

# 🔹 View Container Network Information

```bash
docker inspect container1
```

Filter IP only:

```bash
docker inspect -f \
'{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
container1
```

---

# 🔹 View Network Usage

```bash
docker network inspect my_network
```

Shows connected containers.

---

# 🔹 View Docker Default Bridge

```bash
ip addr show docker0
```

or

```bash
ifconfig docker0
```

---

# 🔹 Check Network Namespace

```bash
lsns -t net
```

---

# 🔹 View Linux Bridge

```bash
brctl show
```

Modern alternative:

```bash
bridge link
```

---

# 🔹 Monitor Docker Network Traffic

Using tcpdump:

```bash
tcpdump -i docker0
```

Monitor overlay traffic:

```bash
tcpdump -i vxlan0
```

---

# 🔹 Test Container Connectivity

Ping another container:

```bash
docker exec -it app1 ping app2
```

Curl service:

```bash
docker exec -it app1 curl http://app2:8080
```

---

# 🔹 View Docker DNS Resolution

Inside container:

```bash
cat /etc/resolv.conf
```

---

# 🔹 Check Listening Ports

```bash
netstat -tulpn
```

Modern command:

```bash
ss -tulpn
```

---

# 🔹 Publish Ports

```bash
docker run -p 8080:80 nginx
```

Specific IP:

```bash
docker run -p 127.0.0.1:8080:80 nginx
```

Random port:

```bash
docker run -P nginx
```

---

# 🔹 Disable Networking

```bash
docker run --network none ubuntu
```

---

# 🔹 Use Multiple Networks

```bash
docker network create frontend_net
docker network create backend_net
```

Run container:

```bash
docker run -dit \
--name app \
--network frontend_net \
nginx
```

Attach second network:

```bash
docker network connect backend_net app
```

---

# 🔹 Docker Compose Network Example

```yaml
version: '3'

services:
  web:
    image: nginx
    networks:
      - frontend

  db:
    image: mysql
    networks:
      - backend

networks:
  frontend:
  backend:
```

---

# 🔹 Swarm Service Networking

Create service:

```bash
docker service create \
--name web \
--network my_overlay \
nginx
```

List services:

```bash
docker service ls
```

Inspect service:

```bash
docker service inspect web
```

---

# 🔹 Troubleshooting Commands

## Check network errors

```bash
docker events
```

---

## View container logs

```bash
docker logs container1
```

---

## Check connectivity

```bash
ping
curl
telnet
nc
```

---

## DNS troubleshooting

```bash
nslookup service_name
```

Install tools:

```bash
apt update && apt install dnsutils -y
```

---

# 🔹 Enterprise Security Commands

## Create isolated internal network

```bash
docker network create \
--internal secure_backend
```

---

## Restrict exposed ports

Good:

```bash
-p 127.0.0.1:3306:3306
```

Avoid:

```bash
-p 0.0.0.0:3306:3306
```

---

# 🔹 Enterprise Real-Time Examples

## Frontend + Backend Isolation

```bash
docker network create frontend_net
docker network create backend_net
```

Frontend:

```bash
docker run -dit \
--network frontend_net \
nginx
```

Backend:

```bash
docker run -dit \
--network backend_net \
mysql
```

API attached to both:

```bash
docker run -dit \
--network frontend_net \
--name api \
ubuntu
```

Attach second network:

```bash
docker network connect backend_net api
```

---

# 🔹 Docker Network Drivers Summary

| Driver  | Purpose                     |
| ------- | --------------------------- |
| bridge  | Default local communication |
| host    | Host stack sharing          |
| overlay | Multi-host networking       |
| macvlan | Direct LAN communication    |
| none    | No networking               |

---

# 🔹 Important Enterprise Commands

| Command                   | Purpose              |
| ------------------------- | -------------------- |
| docker network ls         | List networks        |
| docker network inspect    | View details         |
| docker network create     | Create network       |
| docker network rm         | Remove network       |
| docker network connect    | Attach container     |
| docker network disconnect | Detach container     |
| docker network prune      | Cleanup unused       |
| docker inspect            | Container IP details |

---

# 📌 Best Practices

✅ Use custom bridge networks
✅ Avoid default bridge in production
✅ Use overlay only when needed
✅ Limit exposed ports
✅ Use internal networks for databases
✅ Use DNS names instead of IPs
✅ Monitor traffic using tcpdump/Wireshark
✅ Separate frontend/backend/db networks
✅ Use TLS for APIs & registries
✅ Scan images regularly
