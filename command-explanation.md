# Docker `-d`, `-it`, and `docker exec -it`

| Command           | Meaning                                            | Purpose                            | Example                                | What Happens                            | Sample Output         |
| ----------------- | -------------------------------------------------- | ---------------------------------- | -------------------------------------- | --------------------------------------- | --------------------- |
| `docker run -d`   | Detached Mode                                      | Run container in background        | `bash docker run -d nginx `            | Container starts silently in background | `bash a1b2c3d4e5f6 `  |
| `docker run -it`  | Interactive + TTY                                  | Open terminal inside new container | `bash docker run -it ubuntu bash `     | Opens Ubuntu shell                      | `bash root@c8d12:/# ` |
| `docker exec -it` | Execute command interactively in running container | Access existing/running container  | `bash docker exec -it webserver bash ` | Opens shell inside running container    | `bash root@a1b2:/# `  |

---

# Detailed Comparison Table

| Feature                            | `docker run -d` | `docker run -it` | `docker exec -it` |
| ---------------------------------- | --------------- | ---------------- | ----------------- |
| Creates new container              | Yes             | Yes              | No                |
| Runs in background                 | Yes             | No               | No                |
| Interactive shell                  | No              | Yes              | Yes               |
| Used for applications/services     | Yes             | Sometimes        | No                |
| Used for troubleshooting           | Rarely          | Yes              | Very Common       |
| Needs existing container           | No              | No               | Yes               |
| Common in Production               | Very High       | Medium           | Very High         |
| Container keeps running after exit | Yes             | Usually No       | Yes               |

---

# 1. `docker run -d`

## Definition

`-d` = Detached Mode

Runs container in background and returns container ID.

---

## Command

```bash id="x7a3kq"
docker run -d nginx
```

---

## Output

```bash id="2i5vyo"
8f3d7c2a1e45f9...
```

(Container ID)

---

## Verify

```bash id="w7hbf6"
docker ps
```

### Output

```bash id="w19lx5"
CONTAINER ID   IMAGE   STATUS
8f3d7c2a1e45   nginx   Up 2 minutes
```

---

## Real Usage

| Scenario    | Example |
| ----------- | ------- |
| Web server  | Nginx   |
| API service | Node.js |
| Database    | MySQL   |
| Monitoring  | Grafana |
| CI/CD       | Jenkins |

---

# 2. `docker run -it`

## Definition

| Flag | Meaning        |
| ---- | -------------- |
| `-i` | Interactive    |
| `-t` | Terminal (TTY) |

Used to open terminal access INSIDE container.

---

## Command

```bash id="zfczy7"
docker run -it ubuntu bash
```

---

## Output

```bash id="rxs7z0"
root@4f6a12:/#
```

Now you are INSIDE container.

---

## Example Commands Inside Container

```bash id="v0oz3r"
ls
pwd
cat /etc/os-release
```

### Example Output

```bash id="hfd19m"
/bin
/etc
/usr
```

---

# 3. `docker exec -it`

## Definition

Used to enter an ALREADY RUNNING container interactively.

---

## Step 1 — Run Container

```bash id="n58x5n"
docker run -d --name web nginx
```

---

## Step 2 — Enter Container

```bash id="2v5n64"
docker exec -it web bash
```

---

## Output

```bash id="jzcfk7"
root@a7c91:/#
```

---

## If Bash Not Available

Use `sh`

```bash id="i8k1cs"
docker exec -it web sh
```

---

# Visual Flow

| Command                      | Flow                                 |
| ---------------------------- | ------------------------------------ |
| `docker run -d nginx`        | Create → Start → Background          |
| `docker run -it ubuntu bash` | Create → Start → Attach Terminal     |
| `docker exec -it web bash`   | Existing Container → Attach Terminal |

---

# Real Enterprise Usage

| Team                 | Common Command                       |
| -------------------- | ------------------------------------ |
| DevOps               | `docker exec -it`                    |
| SRE                  | `docker exec -it`                    |
| Developers           | `docker run -it`                     |
| Platform Engineers   | `docker run -d`                      |
| Kubernetes Engineers | `kubectl exec -it` (similar concept) |

---

# Most Common Production Workflow

## Run App

```bash id="lr3pvl"
docker run -d --name app nginx
```

---

## Check Running Containers

```bash id="bn2h1j"
docker ps
```

---

## Enter Container

```bash id="0pmt57"
docker exec -it app bash
```

---

## Check Logs

```bash id="mjlwm6"
docker logs app
```

---

## Stop Container

```bash id="g1v70u"
docker stop app
```

---

# Quick Interview Answers

| Topic             | Answer                                                    |
| ----------------- | --------------------------------------------------------- |
| `-d`              | Runs container in detached/background mode                |
| `-it`             | Opens interactive terminal session                        |
| `docker exec -it` | Opens shell inside running container                      |
| Difference        | `run` creates container, `exec` enters existing container |
