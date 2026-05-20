# Docker `-d`, `-it`, and `docker exec` — Quick Reference

| Command / Flag    | Meaning                              | Purpose                                 | Example                      | What Happens                                             |
| ----------------- | ------------------------------------ | --------------------------------------- | ---------------------------- | -------------------------------------------------------- |
| `-d`              | Detached Mode                        | Run container in background             | `docker run -d nginx`        | Container starts in background and terminal becomes free |
| `-i`              | Interactive Mode                     | Keep STDIN open                         | `docker run -i ubuntu`       | Allows input to container                                |
| `-t`              | TTY Terminal                         | Allocate terminal session               | `docker run -t ubuntu`       | Gives terminal-like shell                                |
| `-it`             | Interactive + TTY                    | Open interactive shell inside container | `docker run -it ubuntu bash` | You enter container shell                                |
| `docker exec`     | Execute command in running container | Run commands inside existing container  | `docker exec app ls`         | Runs `ls` inside running container                       |
| `docker exec -it` | Interactive exec session             | Access shell of running container       | `docker exec -it app bash`   | Opens terminal inside running container                  |

---

# 1. `docker run -d`

## Syntax

```bash id="9yhk9q"
docker run -d <image>
```

## Example

```bash id="g39udj"
docker run -d nginx
```

## Usage

* Web servers
* APIs
* Databases
* Background services
* Production containers

## Output

```bash id="wpcxt5"
a1b2c3d4e5f6...
```

(Container ID)

## Flow

```text id="a3wfrw"
Start Container
      │
      ▼
Run in Background
      │
      ▼
Return Container ID
```

---

# 2. `docker run -it`

## Syntax

```bash id="pw7jlwm"
docker run -it <image> <shell>
```

## Example

```bash id="y89e9g"
docker run -it ubuntu bash
```

## Usage

* Troubleshooting
* Learning Linux
* Manual testing
* Debugging

## Output

```bash id="11kpjc"
root@container:/#
```

(Container shell access)

## Flow

```text id="icg34w"
Start Container
      │
      ▼
Attach Terminal
      │
      ▼
Interactive Shell Access
```

---

# 3. `docker exec`

## Syntax

```bash id="hhlsya"
docker exec <container> <command>
```

## Example

```bash id="2zbn3g"
docker exec webserver ls
```

## Usage

* Run one-time commands
* Check files/processes
* Script automation

## Output

```bash id="a6g7ur"
bin
etc
home
usr
```

## Flow

```text id="ut4gmu"
Existing Running Container
           │
           ▼
Execute Command Inside
           │
           ▼
Return Output
```

---

# 4. `docker exec -it`

## Syntax

```bash id="v2it06"
docker exec -it <container> bash
```

## Example

```bash id="0tmif5"
docker exec -it nginx-server bash
```

## Usage

* Production troubleshooting
* Kubernetes debugging
* Checking logs/configs
* DevOps operations

## Output

```bash id="i1gxot"
root@container:/#
```

## Flow

```text id="5jgh5f"
Running Container
       │
       ▼
Attach Interactive Terminal
       │
       ▼
Shell Access Inside Container
```

---

# Key Difference

| Feature                  | `docker run` | `docker exec` |
| ------------------------ | ------------ | ------------- |
| Creates new container    | Yes          | No            |
| Uses existing container  | No           | Yes           |
| Starts application       | Yes          | No            |
| Used for troubleshooting | Sometimes    | Very Common   |
| Opens shell              | With `-it`   | With `-it`    |

---

# Real Enterprise Scenario

## Start Application

```bash id="63r4eg"
docker run -d --name nginx-web nginx
```

## Verify Running Container

```bash id="umglh9"
docker ps
```

## Access Running Container

```bash id="3z7vkp"
docker exec -it nginx-web bash
```

## Check Files

```bash id="jmxz7r"
ls /etc/nginx
```

---

# Most Common DevOps Commands

| Purpose                      | Command                      |
| ---------------------------- | ---------------------------- |
| Run app in background        | `docker run -d nginx`        |
| Open Ubuntu shell            | `docker run -it ubuntu bash` |
| Access running container     | `docker exec -it app bash`   |
| Run command inside container | `docker exec app ls`         |
| View running containers      | `docker ps`                  |
| View logs                    | `docker logs app`            |
| Stop container               | `docker stop app`            |

---

# Interview Summary

| Command           | One-Line Explanation                                |
| ----------------- | --------------------------------------------------- |
| `-d`              | Runs container in detached/background mode          |
| `-it`             | Opens interactive terminal session inside container |
| `docker exec`     | Executes command inside running container           |
| `docker exec -it` | Opens shell access to existing running container    |
