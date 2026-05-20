# Docker & Container Notes (Simple Version)

# What is a Container?

A container is a lightweight package that contains:

* Application code
* Required libraries
* Dependencies
* Runtime environment

So the application runs the same everywhere.

### Simple Definition

> Container = Application + Dependencies + Minimal System Files

---

# Why Containers are Popular?

* Lightweight
* Fast startup
* Portable
* Easy deployment
* Same behavior in all environments

---

# Containers vs Virtual Machines (VMs)

| Feature        | Container     | Virtual Machine |
| -------------- | ------------- | --------------- |
| Size           | Small         | Large           |
| Startup Time   | Seconds       | Minutes         |
| OS Included    | No full OS    | Full OS         |
| Performance    | Faster        | Slower          |
| Resource Usage | Low           | High            |
| Isolation      | Process-level | Full OS-level   |
| Portability    | High          | Medium          |

---

# Why Containers are Lightweight?

Containers share the Host OS Kernel.

They do NOT carry a full operating system like VMs.

That is why:

* Ubuntu Container Image → ~22 MB
* Ubuntu VM Image → ~2.3 GB

---

# Container Internal Structure

## Common Files/Folders Inside Container

| Folder  | Purpose             |
| ------- | ------------------- |
| `/bin`  | Basic commands      |
| `/sbin` | System commands     |
| `/etc`  | Configuration files |
| `/lib`  | Libraries           |
| `/usr`  | User utilities      |
| `/var`  | Logs & temp files   |
| `/root` | Root user home      |

---

# What Containers Use from Host OS?

| Component   | Usage                 |
| ----------- | --------------------- |
| Kernel      | System operations     |
| Networking  | Internet connectivity |
| File System | Shared access         |
| Namespaces  | Isolation             |
| cgroups     | Resource limits       |

---

# What is Docker?

Docker is a containerization platform.

Using Docker you can:

* Build Images
* Run Containers
* Push Images
* Pull Images
* Manage Containers

### Simple Definition

> Docker is a tool that implements containerization.

---

# Docker Architecture

![Image](https://images.openai.com/static-rsc-4/_kd8m33kiNRNSN4oiq1zmbzBfd_d9WsKVrRrv2Y5yI5R-ZANfhrfL9XwDTqzP3HJs1pcnp9dDSl-QbgyABJfTzeqQbfp_EjxHGSwa_HwtJp0wZEZo0vs3ailznqPNuYQBrYEpKtSSoj3Srpgpwu8I3a4ihFCN-nHk1TXsLVYKtQdl__zh3hlpKVZIOJlRxfE?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/VpuBFdpnfVtXtR16LlylXp6kifPTYeWlBZFtSr1fEqHeoVJ2TCgyW1YFyM6_nlWymGyfDk78eXmH05XgkgPNHPPSopCVOIL0pJ2cscLxvkIpH6F2D203rM2U1D0OyQaslOvq7StHVl439b5d72wfdgVgWOQBBxvIoG6Z_jsm8Q8NeGNkvfjNvyfMjnD9sEFe?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/YDYXQ64fkNAqmtcuFk2M7V1o5BpYmM0VRSSZ8xFEB8-saEDBI384E1OpOSqPso5iJNhBZCF42ZATH120RYSuINi5WiCc1cEI99DNn3TnJJ-6t4fLbQmRIk6ugopdjj4LhbJxwGAAvGPm-x1GFg0sBJNSGvSZwu0loP4NYG1bix7X1MCs_tS8Bp1eOorCSQlM?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ZH5LHZwhgjVinSswQ0thDwAWzYC42-AhymkQzyblPP_lPWFBPZLbAak-wamiZWX-cvlMv2oBaODyTmjGb3ixXq7QKCRZt-UF-kEAkHn2aQFod6G5thch0texGoJFnhhOuXIdQKibb-Wy8QdPS5hCsfoXIbPAi4LFK0HFoqled1lysLJEHxEdW3GmfPN8QzD7?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ybyeTgzuJ52bVjK5BxEtoFSSTdRot2KW5ouy0xabJNvIV8emY1Jsf-tF8qslnXhXHiFVpNcaXjy6dYN9QSVddS8sodCSqIvU_mF74hMK7MfuatCm0Pt98WZJe3inkpd4j9g4RklBmXT1DIy1bzsI39Byy6HPlCtvb6dyUT2cUY-yxCtes56eREnfCCJTGAMU?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/fBe66pqEJ2_dkPZRFyS_kXpwf6CeeUhqphdG4XpDrRYPJK4YOj6aymAjy2-K-NB6BusXJ62tRgATcy1FNG_ziir1qQMUaH9BFpch-X3NfiQlhBqedeFayUq3sIBIS5UL90HB3I7zOKbVioReuS7xx0bg7poSV-G5iVtzKiF6NZTaQE-1Hno2C6bPZgRMsffQ?purpose=fullsize)

---

# Important Docker Components

| Component        | Meaning                         |
| ---------------- | ------------------------------- |
| Docker Client    | User interface (`docker`)       |
| Docker Daemon    | Main Docker service (`dockerd`) |
| Docker Image     | Read-only template              |
| Docker Container | Running instance of image       |
| Docker Registry  | Stores images                   |
| Dockerfile       | Instructions to build image     |

---

# Docker Lifecycle

| Command        | Purpose                |
| -------------- | ---------------------- |
| `docker build` | Build image            |
| `docker run`   | Run container          |
| `docker push`  | Push image to registry |
| `docker pull`  | Download image         |

---

# Dockerfile

Dockerfile contains instructions to create Docker Images.

Example:

```dockerfile
FROM ubuntu:22.04

RUN apt update

RUN apt install -y nginx

COPY . /app

WORKDIR /app

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
```

---

# Image vs Container

| Image     | Container        |
| --------- | ---------------- |
| Template  | Running instance |
| Read-only | Executable       |
| Static    | Dynamic          |

### Simple Example

* Image = Class
* Container = Object

---

# Docker Installation (Ubuntu)

## Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
```

---

# Verify Docker Service

```bash
sudo systemctl status docker
```

---

# Start Docker Service

```bash
sudo systemctl start docker
```

---

# Give Docker Access to User

```bash
sudo usermod -aG docker ubuntu
```

Logout/Login after this.

---

# Verify Docker Installation

```bash
docker run hello-world
```

Expected Output:

```bash
Hello from Docker!
```

---

# Docker Registry

A Docker Registry stores Docker Images.

Popular Registries:

| Registry                                                    | Type           |
| ----------------------------------------------------------- | -------------- |
| [Docker Hub](https://hub.docker.com?utm_source=chatgpt.com) | Public         |
| [Quay.io](https://quay.io?utm_source=chatgpt.com)           | Public/Private |
| AWS ECR                                                     | Private        |
| Azure ACR                                                   | Private        |

---

# Docker Login

```bash
docker login
```

---

# Build Docker Image

```bash
docker build -t myimage:latest .
```

---

# List Images

```bash
docker images
```

---

# Run Container

```bash
docker run -it myimage
```

---

# Push Image to Docker Hub

```bash
docker push username/myimage
```

---

# Important Docker Commands

| Command             | Purpose            |
| ------------------- | ------------------ |
| `docker ps`         | Running containers |
| `docker ps -a`      | All containers     |
| `docker images`     | List images        |
| `docker pull`       | Download image     |
| `docker push`       | Upload image       |
| `docker build`      | Build image        |
| `docker run`        | Run container      |
| `docker stop`       | Stop container     |
| `docker rm`         | Remove container   |
| `docker rmi`        | Remove image       |
| `docker logs`       | Container logs     |
| `docker exec -it`   | Enter container    |
| `docker inspect`    | Detailed info      |
| `docker network ls` | List networks      |
| `docker volume ls`  | List volumes       |

---

# Docker Container Workflow

![Image](https://images.openai.com/static-rsc-4/j8S5bpWObadfXkeZqz8XTb3IZD6OESElMCKVeEYeO6xZZmhrFds7hIoajb6Rxgj7BnukgqcMlw_YlETxriUNP3YvPbkL771gyFw_Kd47iCsa-d_oGGkKX0jbqyTGZRGovrR3BDg_dTE15gPPOYkHkxoNgV8OreABQDjq9pegqJs60GW_T8SuPX9d2wbKGTwq?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/MP3BopbNE7JuxtIBGmWGdIh166yat7Os6IIKq3HI6VcF9gvFk7EHt5NkdYKAPB1smWF17ToKxOSYe4g63RsttzUhW9-0pOmMTZ1gYNR7W-Ez6O6r-4yRXIT8wi3h1ExAVQREOizH0wNzar1tZvtL6v_Dnvd_MhGqKlwG9DzuLPN8dI4wH07n_j0IRlBmQKI5?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/S3iHKf5CM9OeHRPwXV-PUy-yqnJYJtQ9MyF-L-aWTC53RBuoXBJvBAhkS_4O-AcMqBSGdmz5KMuxt1dqjLQk2nNKod2KyJfsXALts-JblU0mYnjB0UZDWeCDORXblJGc1_aKZ1bDVfSuaCsMSjH-oFNtZGTZdzp9lddAh3yRJ5nrOvI0db0fhJM7F1KSdo19?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/qxS4P3LQdEBjkiYgAfV8agONbFt25Sd-8QZLcTkY6HpXiq0sqawU0QPFVZjaG-Thq-x9fcPSaLmqE94fv_0TfSMLNj6cLxK_hPKS0c484xzpGZUwN08kHKwKGbdCY3-M31vHG4-JEHWuQKLnP8g8e3Ne5jt93AzLznWMN5imbaZUz5tKF76Wu3loD1IAFTia?purpose=fullsize)

---

# Container vs VM Visualization

![Image](https://images.openai.com/static-rsc-4/Xy-eN-0Fi7dTT9Doa3HkhTU2CG4hIRB77nALTEDRqS118JRAanu9HFiXFwmNnVjSaL_XKL8vWXVrscvBJnoIn13NVbciupNwXMEb9cL3sSU-z0dDvGgeTkiMngskvs-yOaXBNp1xmnQ0nYr1uL2v_YTwWxzKi0X5tuRCh_t7liFSajTtF0EfLT49ObDBNLCA?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/naXTwHvcqUJ-oW5N8B0y1WD9n60iG18JpPGOv8wYQRkIUSmfT4xFyj4woVKGtj9iObtpqizCp68gaADDPemOni_jkuznxH_qalHO41P8amuk-gVmlvoFBAZyR21-ldfn9izLdS0qd7LlA2YIMGpEgA_4m-3rWiZhU-1ZZXKYH2qCLYzaXpkvd2pEm0q0KTbK?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/O87QK1AGEbYKZtXJBawjK3wrDC_1ruqVh5rETVmS6Nivesr3v0Y4nJmsn2DmUoUh7vgwinnvdT7o7d4TUCA7jTS6Rnw-H7xxOvtHvWxBFTyKONn0x5RHDR3MTPSmveCnvi42tw4-nWbXvS8HEQ4jd2C6BuJC2ARkJZ3V3J_isLyAmW-B1m_bgzPrIBDdTCxS?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/XbbgQbBLOSRWZ8IKU3UwTqLjfsLbvF_-sqyu7SfS3wrUiOZGyHo0plpBMeqex4-rcFKg5KzAp55ErtsWe8W8txvsC9f3rA5IosrIxyPizcE6HVouDAQdqurDvWg5mRj0iIs4Cy6LWSk1HZmcNICjVhd3dOXtDrs5JIi2MipDpprcxtZoLz8glbXIu5PnzpsM?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/DLO7WSJ5_4yvYC2JmlvP_L8QoQ4ubXXhle4Eq84pw5qIEaibR7VaUxUlT1xDLEUa3zsRgCii3LJfuAbUjz7dOEDKZlmY-19DbnD8KZ2TbCjbaAdsNVqCGREhJnjIieFvUNDYUwKvFBYkRkQCtfsV0oanwULQf1vI5svGd2-c5FGKKc2QtKnMzpSzv8prENKD?purpose=fullsize)

---

# Final Summary

| Topic       | Simple Meaning        |
| ----------- | --------------------- |
| Container   | App + Dependencies    |
| Docker      | Container platform    |
| Image       | Template              |
| Container   | Running Image         |
| Dockerfile  | Build instructions    |
| Registry    | Image storage         |
| Daemon      | Docker engine         |
| Lightweight | Shares host OS kernel |
