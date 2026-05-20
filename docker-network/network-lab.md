
# 🚀 Recommended Practice Labs

## Lab 1

* Create custom bridge
* Connect 2 containers
* Test DNS

# 📘 Docker Networking Lab – Custom Bridge + 2 Containers + DNS Test

## 🔹 Step 1 — Create Custom Bridge Network

```bash
docker network create my_bridge
```

Verify:

```bash
docker network ls
```

---

## 🔹 Step 2 — Run First Container

```bash
docker run -dit \
--name app1 \
--network my_bridge \
ubuntu
```

---

## 🔹 Step 3 — Run Second Container

```bash
docker run -dit \
--name app2 \
--network my_bridge \
ubuntu
```

---

## 🔹 Step 4 — Verify Containers in Network

```bash
docker network inspect my_bridge
```

Look for:

```text
Containers:
app1
app2
```

---

## 🔹 Step 5 — Login to app1

```bash
docker exec -it app1 bash
```

---

## 🔹 Step 6 — Install Ping Utility

Inside container:

```bash
apt update
apt install iputils-ping -y
```

---

## 🔹 Step 7 — Test Docker DNS Resolution

Ping second container using container name:

```bash
ping app2
```

Expected:

```text
PING app2 (172.x.x.x)
```

This confirms:

✅ Container communication works
✅ Docker internal DNS works
✅ Custom bridge network works

---

# 📌 Architecture

```text
           my_bridge Network
        -----------------------
        |                     |
     +------+             +------+
     | app1 | <---------> | app2 |
     +------+             +------+
```

---

# 📌 Important Learning

| Concept                | Meaning                    |
| ---------------------- | -------------------------- |
| Custom Bridge          | Isolated Docker network    |
| Container DNS          | Containers resolve by name |
| Internal Communication | Containers talk privately  |
| Secure Networking      | No public exposure needed  |

---

# 📌 Cleanup Lab

Stop containers:

```bash
docker stop app1 app2
```

Remove containers:

```bash
docker rm app1 app2
```

Remove network:

```bash
docker network rm my_bridge
```

---

## Lab 2

* Create overlay network
* Deploy swarm services
* Test multi-host communication

# 📘 Docker Overlay Network Lab (Simple)

# 🔹 Step 1 — Initialize Docker Swarm

On Manager Node:

```bash id="v2xg5w"
docker swarm init
```

Expected:

```text id="2z2n1z"
Swarm initialized
```

---

# 🔹 Step 2 — Create Overlay Network

```bash id="pyi1ul"
docker network create \
--driver overlay \
my_overlay
```

Verify:

```bash id="b6m8n6"
docker network ls
```

---

# 🔹 Step 3 — Deploy First Service

```bash id="m7e5ri"
docker service create \
--name web1 \
--network my_overlay \
nginx
```

---

# 🔹 Step 4 — Deploy Second Service

```bash id="s93c6d"
docker service create \
--name web2 \
--network my_overlay \
nginx
```

---

# 🔹 Step 5 — Verify Services

```bash id="tq8cwl"
docker service ls
```

Expected:

```text id="6kqqsq"
web1
web2
```

---

# 🔹 Step 6 — Verify Overlay Network

```bash id="mr68yf"
docker network inspect my_overlay
```

Check:

```text id="1ymg1v"
Containers
Peers
VXLAN
```

---

# 🔹 Step 7 — Test Service Communication

Open shell inside one container:

```bash id="tuvnqb"
docker ps
```

Copy container ID.

Enter container:

```bash id="u3eb2m"
docker exec -it <container_id> sh
```

---

# 🔹 Step 8 — Test Docker DNS

Ping second service:

```bash id="6kvn6x"
ping web2
```

OR

```bash id="2e16gq"
curl http://web2
```

Expected:

```text id="8p2qfk"
Welcome to nginx
```

---

# 📌 Architecture

```text id="x0l3zr"
           Overlay Network (VXLAN)
     ---------------------------------

      Docker Host 1         Docker Host 2
     +-------------+       +-------------+
     |   web1      |<----->|    web2     |
     +-------------+       +-------------+

          Multi-host communication
```

---

# 📌 What You Learned

| Concept                  | Meaning                               |
| ------------------------ | ------------------------------------- |
| Swarm                    | Docker clustering                     |
| Overlay Network          | Multi-host container network          |
| VXLAN                    | Tunnel between hosts                  |
| Service Discovery        | DNS by service name                   |
| Multi-host Communication | Containers across servers communicate |

---

# 📌 Cleanup

Remove services:

```bash id="2x7x2n"
docker service rm web1 web2
```

Remove network:

```bash id="gt6fqs"
docker network rm my_overlay
```

Leave swarm:

```bash id="0lyi96"
docker swarm leave --force
```

---

## Lab 3

* Create isolated backend network
* Restrict DB exposure
* Add reverse proxy

# 📘 Docker Secure Networking Lab (Simple)

# 🔹 Step 1 — Create Frontend Network

```bash id="q9cz18"
docker network create frontend_net
```

---

# 🔹 Step 2 — Create Backend Network

```bash id="v0tdmt"
docker network create backend_net
```

---

# 🔹 Step 3 — Run MySQL Database (Backend Only)

```bash id="ufy7n9"
docker run -dit \
--name mysql_db \
--network backend_net \
-e MYSQL_ROOT_PASSWORD=admin123 \
mysql
```

✅ Database is NOT exposed publicly
✅ No `-p` used

---

# 🔹 Step 4 — Run Backend API Container

```bash id="gq9dmi"
docker run -dit \
--name backend_api \
--network backend_net \
nginx
```

---

# 🔹 Step 5 — Connect API to Frontend Network

```bash id="54n1vx"
docker network connect frontend_net backend_api
```

Now API can talk to:

* Frontend
* Database

---

# 🔹 Step 6 — Run Reverse Proxy (Public Access)

```bash id="ed1c2z"
docker run -dit \
--name reverse_proxy \
--network frontend_net \
-p 80:80 \
nginx
```

✅ Only reverse proxy exposed publicly
✅ Database remains private

---

# 🔹 Step 7 — Verify Networks

```bash id="p5p93u"
docker network inspect frontend_net
```

```bash id="scz4i9"
docker network inspect backend_net
```

---

# 🔹 Step 8 — Test Internal Communication

Login to API container:

```bash id="3jvqu8"
docker exec -it backend_api bash
```

Install ping:

```bash id="l0ggm8"
apt update && apt install iputils-ping -y
```

Ping database:

```bash id="8jht10"
ping mysql_db
```

---

# 📌 Architecture

```text id="8s40qa"
                Internet
                    |
            +----------------+
            | Reverse Proxy  |
            +----------------+
                    |
              frontend_net
                    |
              backend_api
                    |
              backend_net
                    |
                mysql_db
```

---

# 📌 Security Benefits

| Component       | Security                |
| --------------- | ----------------------- |
| Reverse Proxy   | Only public entry point |
| Backend Network | Private communication   |
| Database        | No public exposure      |
| Custom Networks | Isolation               |

---

# 📌 Important Learning

✅ Network segmentation
✅ Secure DB isolation
✅ Reverse proxy architecture
✅ Internal Docker DNS
✅ Multi-network containers

---

# 📌 Cleanup

Stop containers:

```bash id="vg7yqf"
docker stop reverse_proxy backend_api mysql_db
```

Remove containers:

```bash id="ul0v4m"
docker rm reverse_proxy backend_api mysql_db
```

Remove networks:

```bash id="wzlmfc"
docker network rm frontend_net backend_net
```
