# Install Docker on Ubuntu

```bash id="94y36f"
sudo apt update

sudo apt install docker.io -y
```

---

# Start Docker Service

```bash id="ee4vf7"
sudo systemctl start docker

sudo systemctl enable docker
```

---

# Verify Docker Service

```bash id="f3wpn7"
sudo systemctl status docker
```

---

# Add User to Docker Group

```bash id="zz2l89"
sudo usermod -aG docker $USER
```

---

# Test Docker

```bash id="3s0fm4"
docker run hello-world
```

---
