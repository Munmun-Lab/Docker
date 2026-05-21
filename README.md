# Docker & Container Notes (Simple Version)

# What is a Container?

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

A container is a lightweight package that contains:

* Application code
* Required libraries
* Dependencies
* Runtime environment

So the application runs the same everywhere.

### Simple Definition

> Container = Application + Dependencies + Minimal System Files

A container is a bundle of Application, Application libraries required to run your application and the minimum system dependencies.

![Screenshot 2023-02-07 at 7 18 10 PM](https://user-images.githubusercontent.com/43399466/217262726-7cabcb5b-074d-45cc-950e-84f7119e7162.png)

---

# Why Containers are Popular?

* Lightweight
* Fast startup
* Portable
* Easy deployment
* Same behavior in all environments

---

# Containers vs Virtual Machines

| Topic                | Containers                                 | Virtual Machines                            |
| -------------------- | ------------------------------------------ | ------------------------------------------- |
| Resource Utilization | Share Host OS Kernel, lightweight and fast | Have full OS and Hypervisor, resource heavy |
| Portability          | Highly portable across environments        | Need compatible Hypervisor                  |
| Security             | Less isolated because Host OS is shared    | Better isolation with separate OS           |
| Management           | Easier and faster to manage                | More complex management                     |
| Size                 | Small                                      | Large                                       |
| Startup Time         | Starts in seconds                          | Takes minutes                               |
| Performance          | Near native performance                    | Slightly slower                             |
| OS Requirement       | Shares Host OS                             | Separate Guest OS required                  |
| Infrastructure       | Lightweight                                | Heavy infrastructure                        |
| Use Case             | Microservices, DevOps, CI/CD               | Legacy apps, strong isolation               |
| Boot Process         | Fast                                       | Slow                                        |
| Resource Consumption | Low CPU/RAM usage                          | High CPU/RAM usage                          |
| Scalability          | Easy horizontal scaling                    | Slower scaling                              |
| Isolation Level      | Process-level isolation                    | Full machine isolation                      |
| Examples             | Docker, Podman                             | VMware, Hyper-V, VirtualBox                 |

---

# Why Containers are Lightweight?

Containers are lightweight because they:

* Share the Host Operating System Kernel
* Do not include a full Operating System
* Include only required application files and dependencies
* Use minimal system resources

Unlike Virtual Machines, containers do not need:

| Containers Do NOT Need      | Result                  |
| --------------------------- | ----------------------- |
| Separate Guest OS           | Smaller in size         |
| Full OS libraries           | Faster to start         |
| Heavy storage allocation    | Faster to deploy        |
| Full machine virtualization | More resource efficient |

That is why:

* Ubuntu Container Image → ~22 MB
* Ubuntu VM Image → ~2.3 GB

![Screenshot 2023-02-08 at 3 12 38 PM](https://user-images.githubusercontent.com/43399466/217493284-85411ae0-b283-4475-9729-6b082e35fc7d.png)

---

# Container Internal Structure

## Common Files/Folders Inside Container

To provide a better picture of files and folders that containers base images have and files and folders that containers use from host operating system (not 100 percent accurate -> varies from base image to base image). Refer below.

| Folder  | Purpose             | Details / Examples                                            |
| ------- | ------------------- | ------------------------------------------------------------- |
| `/bin`  | Basic commands      | Contains binary executable files such as `ls`, `cp`, `ps`     |
| `/sbin` | System commands     | Contains system executable files such as `init`, `shutdown`   |
| `/etc`  | Configuration files | Contains configuration files for system services              |
| `/lib`  | Libraries           | Contains library files used by executable binaries            |
| `/usr`  | User utilities      | Contains applications, libraries, utilities and documentation |
| `/var`  | Logs & temp files   | Contains logs, spool files, cache and temporary data          |
| `/root` | Root user home      | Home directory of the root user                               |

---

# What Containers Use from Host OS?

| Component        | Usage                 | Details                                                                               |
| ---------------- | --------------------- | ------------------------------------------------------------------------------------- |
| Kernel           | System operations     | Host kernel handles system calls and provides access to CPU, memory and I/O resources |
| Networking Stack | Internet connectivity | Containers use the host networking stack directly or through virtual networks         |
| File System      | Shared access         | Containers can access host files using bind mounts for read/write operations          |
| Namespaces       | Isolation             | Linux namespaces isolate processes, file systems, process IDs and networks            |
| cgroups          | Resource limits       | Control groups limit and manage CPU, memory and I/O usage for containers              |

---

# What is Docker?

Docker is a containerization platform that provides easy way to containerize your applications, which means, using Docker you can build container images, run the images to create containers and also push these containers to container regestries such as DockerHub, Quay.io and so on.

In simple words, you can understand as `containerization is a concept or technology` and `Docker Implements Containerization`.

Using Docker you can:

* Build Images
* Run Containers
* Push Images
* Pull Images
* Manage Containers

### Simple Definition

> Docker is a tool that implements containerization.

---

### Docker Architecture ?

![image](https://user-images.githubusercontent.com/43399466/217507877-212d3a60-143a-4a1d-ab79-4bb615cb4622.png)

The above picture, clearly indicates that Docker Deamon is brain of Docker. If Docker Deamon is killed, stops working for some reasons, Docker is brain dead


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
| Docker Engine    | Main runtime                    |
| Docker Client    | User interface (`docker`)       |
| Docker CLI       | ommand line                     |
| Docker Daemon    | Main Docker service (`dockerd`) |
| Docker Image     | Read-only template              |
| Docker Container | Running instance of image       |
| Docker Registry  | Stores images                   |
| Dockerfile       | Instructions to build image     |

---

# Docker Daemon (`dockerd`)

Docker daemon is the main background service of Docker which listens for Docker API requests
It manages Docker containers, images, networks, and volumes.
Whenever a user runs a Docker command, the daemon performs the actual task.
A daemon can also communicate with other daemons to manage Docker services.

| Item                   | Details                                           |
| ---------------------- | ------------------------------------------------- |
| Definition             | Background service that manages Docker operations |
| Main Work              | Manages containers, images, networks, and volumes |
| Runs In                | Background                                        |
| Receives Commands From | Docker Client                                     |
| Simple Analogy         | Engine of a car                                   |
| Example Command        | `docker run nginx`                                |

---

# Docker Client (`docker`)

Docker client is the command-line tool used to interact with Docker.
Users run Docker commands through the client, and it sends requests to the Docker daemon.
The docker command uses the Docker API. The Docker client can communicate with more than one daemon.

| Item                 | Details                                   |
| -------------------- | ----------------------------------------- |
| Definition           | Command-line interface for Docker         |
| Purpose              | Sends commands to Docker daemon           |
| Common Commands      | `docker run`, `docker build`, `docker ps` |
| Communication Method | Docker API                                |
| Simple Analogy       | Remote control                            |

---

# Docker Desktop

Docker Desktop is an easy-to-install application for your Mac, Windows or Linux environment that enables you to build and share containerized applications and microservices. 
It includes Docker daemon, Docker client, Kubernetes, Docker Compose, Docker Content Trust, and Credential Helper.

| Item           | Details                                    |
| -------------- | ------------------------------------------ |
| Definition     | Complete Docker application package        |
| Supported OS   | Windows, Mac, Linux                        |
| Includes       | Docker daemon, client, Compose, Kubernetes |
| Purpose        | Simplifies Docker setup and usage          |
| Simple Analogy | All-in-one Docker toolkit                  |

---

# Docker Registry

A Docker registry stores Docker images. Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default. You can even run your own private registry.

When you use the docker pull or docker run commands, the required images are pulled from your configured registry. When you use the docker push command, your image is pushed to your configured registry. Users can download images using `docker pull` and upload images using `docker push`.

| Item            | Details                                                     |
| --------------- | ----------------------------------------------------------- |
| Definition      | Storage location for Docker images                          |
| Public Registry | [Docker Hub](https://hub.docker.com?utm_source=chatgpt.com) |
| Pull Images     | `docker pull nginx`                                         |
| Push Images     | `docker push myimage`                                       |
| Purpose         | Store and share Docker images                               |
| Simple Analogy  | App store for Docker images                                 |

---

# Docker objects

When you use Docker, you are creating and using images, containers, networks, volumes, plugins, and other objects.

---

# Dockerfile

A Dockerfile is a text file where you provide the steps to build your Docker Image. 
It helps automate image creation.

| Item                | Details                                  |
| ------------------- | ---------------------------------------- |
| Definition          | File containing image build instructions |
| Purpose             | Automates Docker image creation          |
| File Type           | Text file                                |
| Common Instructions | `FROM`, `RUN`, `COPY`, `CMD`             |
| Simple Analogy      | Cooking recipe                           |
| Example             | `FROM ubuntu:22.04`                      |

---

# Docker Image

A Docker image is a read-only template used to create containers.
It contains application code, libraries, dependencies, and configurations.

An image is a read-only template with instructions for creating a Docker container. Often, an image is based on another image, with some additional customization. For example, you may build an image which is based on the ubuntu image, but installs the Apache web server and your application, as well as the configuration details needed to make your application run.

You might create your own images or you might only use those created by others and published in a registry. To build your own image, you create a Dockerfile with a simple syntax for defining the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

| Item            | Details                                   |
| --------------- | ----------------------------------------- |
| Definition      | Template used to create containers        |
| Contains        | Application, dependencies, configurations |
| Built Using     | Dockerfile                                |
| Reusable        | Yes                                       |
| Lightweight     | Yes                                       |
| Layer Based     | Yes                                       |
| Simple Analogy  | Blueprint/template                        |
| Example Command | `docker build -t myimage .`               |

---

# Docker Container

A container is a running instance of a Docker image.
It runs applications in an isolated environment.

| Item            | Details                            |
| --------------- | ---------------------------------- |
| Definition      | Running instance of a Docker image |
| Purpose         | Runs applications                  |
| Created From    | Docker Image                       |
| Example Command | `docker run nginx`                 |
| Simple Analogy  | Running application/machine        |

---

# Docker Network

Docker network allows containers to communicate with each other.
It helps connect application containers securely.

| Item            | Details                                  |
| --------------- | ---------------------------------------- |
| Definition      | Communication layer between containers   |
| Purpose         | Enables container communication          |
| Example         | App container connecting to DB container |
| Simple Analogy  | Wi-Fi/router                             |
| Example Command | `docker network ls`                      |

---

# Docker Volume

Docker volume provides persistent storage for containers.
Data stored in volumes remains safe even if containers are deleted.

| Item            | Details                               |
| --------------- | ------------------------------------- |
| Definition      | Persistent storage for containers     |
| Purpose         | Stores container data permanently     |
| Data Safety     | Data remains after container deletion |
| Common Use      | Database storage                      |
| Simple Analogy  | External hard disk                    |
| Example Command | `docker volume ls`                    |

---

# Docker Workflow

Docker workflow shows the basic process of creating and running containers.

| Step | Action                   |
| ---- | ------------------------ |
| 1    | Write Dockerfile         |
| 2    | Build Docker Image       |
| 3    | Store Image in Registry  |
| 4    | Pull Image from Registry |
| 5    | Run Container from Image |

---

# Common Docker Commands

These are some commonly used Docker commands for daily operations.

| Command                     | Purpose                 |
| --------------------------- | ----------------------- |
| `docker build -t myimage .` | Build Docker image      |
| `docker images`             | List images             |
| `docker run nginx`          | Run container           |
| `docker ps`                 | List running containers |
| `docker stop <id>`          | Stop container          |
| `docker rm <id>`            | Remove container        |
| `docker pull nginx`         | Download image          |
| `docker push myimage`       | Upload image            |
| `docker volume ls`          | List volumes            |
| `docker network ls`         | List networks           |

---

# Real-Life Analogy

These analogies help simplify Docker concepts for easier understanding.

| Docker Component | Real-Life Example    |
| ---------------- | -------------------- |
| Dockerfile       | Recipe               |
| Image            | Cake design/template |
| Container        | Actual cake          |
| Docker Client    | Remote control       |
| Docker Daemon    | Engine/machine       |
| Registry         | App store            |
| Docker Desktop   | Complete toolkit     |
| Volume           | External hard disk   |
| Network          | Wi-Fi/router         |

---

# Docker Lifecycle

| Command        | Purpose                | Details                                                          |
| -------------- | ---------------------- | ---------------------------------------------------------------- |
| `docker build` | Build image            | Builds Docker images from a Dockerfile                           |
| `docker run`   | Run container          | Runs a container from a Docker image                             |
| `docker push`  | Push image to registry | Pushes container images to public/private registries for sharing |
| `docker pull`  | Download image         | Downloads images from a Docker registry                          |

![Screenshot 2023-02-08 at 4 32 13 PM](https://user-images.githubusercontent.com/43399466/217511949-81f897b2-70ee-41d1-b229-38d0572c54c7.png)

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
# Dockerfile Instructions

| Instruction | Purpose               |
| ----------- | --------------------- |
| FROM        | Base image            |
| RUN         | Execute commands      |
| COPY        | Copy files            |
| ADD         | Copy/extract          |
| WORKDIR     | Set working directory |
| ENV         | Environment variables |
| EXPOSE      | Open ports            |
| CMD         | Default command       |
| ENTRYPOINT  | Main executable       |

---

# Image vs Container

| Image     | Container        |
| --------- | ---------------- |
| Template  | Running instance |
| Read-only | Executable       |
| Static    | Dynamic          |

# Docker Installation (Ubuntu)

| Step                       | Command                          | Purpose                                |
| -------------------------- | -------------------------------- | -------------------------------------- |
| Install Docker             | `sudo apt update`                | Update package list                    |
|                            | `sudo apt install docker.io -y`  | Install Docker                         |
| Verify Docker Service      | `sudo systemctl status docker`   | Check Docker service status            |
| Start Docker Service       | `sudo systemctl start docker`    | Start Docker daemon                    |
| Give Docker Access to User | `sudo usermod -aG docker ubuntu` | Add user to Docker group               |
| Re-login                   | Logout/Login                     | Apply Docker group permissions         |
| Verify Docker Installation | `docker run hello-world`         | Verify Docker is working               |
| Expected Output            | `Hello from Docker!`             | Successful Docker installation message |

---

# Clone the repository and run the docker image to push docker hub

| Step                     | Command                               | Purpose                                       |
| ------------------------ | ------------------------------------- | --------------------------------------------- |
| Docker Login             | `docker login`                        | Login to Docker Hub registry                  |
| Build Docker Image       | `docker build -t myimage:latest .`    | Build Docker image from Dockerfile            |
| List Images              | `docker images`                       | List available Docker images                  |
| Run Container            | `docker run -it myimage:latest`       | Run container from Docker image               |
| Push Image to Docker Hub | `docker push username/myimage:latest` | Push image to Docker Hub registry for sharing |

---

# Container Registries

# What is Container Registry?

Central repository storing container images.

---

# Registry Examples

| Registry                | Provider         |
| ----------------------- | ---------------- |
| Docker DockerHub        | Public registry  |
| Amazon Web Services ECR | AWS registry     |
| Google GCR              | Google registry  |
| GHCR                    | GitHub registry  |
| Harbor                  | Private registry |

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

# Registry Workflow

```text id="mjlwm3"
Developer
    ↓
Build Image
    ↓
Push to Registry
    ↓
Kubernetes Pulls Image
```

---

```bash id="sl7w9i"
- Docker Login: docker login
- Tag Image: docker tag mynginx:v1 username/mynginx:v1
- Push Image: docker push username/mynginx:v1
- Pull Private Image: docker pull username/mynginx:v1
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

