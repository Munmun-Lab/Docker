`ENTRYPOINT` is **not mandatory**.
A Dockerfile can work perfectly with only `CMD`.

Perfect — simplest possible explanation 👇

# 🔹 Think Like This

| Thing        | Meaning                 |
| ------------ | ----------------------- |
| `ENTRYPOINT` | Main fixed command      |
| `CMD`        | Default extra arguments |

---

# 🔹 Example 1 → Only CMD

```dockerfile id="av7z8r"
FROM ubuntu

CMD ["echo","Hello"]
```

Run container:

```bash id="9yl0dh"
docker run myimage
```

Output:

```bash id="jlwmgf"
Hello
```

Now override it:

```bash id="civf7s"
docker run myimage date
```

Output:

```bash id="0k3pxu"
Tue May 20
```

👉 Because `CMD` is replaceable.

---

# 🔹 Example 2 → ENTRYPOINT + CMD

```dockerfile id="63lmkr"
FROM ubuntu

ENTRYPOINT ["echo"]

CMD ["Hello"]
```

Run:

```bash id="3wfcpd"
docker run myimage
```

Actual execution:

```bash id="50y8q6"
echo Hello
```

Output:

```bash id="aqq7g7"
Hello
```

---

Now run:

```bash id="k5i6wb"
docker run myimage Hi
```

Actual execution:

```bash id="c5j5dr"
echo Hi
```

Output:

```bash id="ylq6o0"
Hi
```

👉 Here:

* `ENTRYPOINT` stays fixed (`echo`)
* `CMD` changes (`Hello` → `Hi`)

---

# 🔹 Nginx Real Example

```dockerfile id="p26ujg"
FROM ubuntu

RUN apt update && apt install -y nginx

ENTRYPOINT ["nginx"]

CMD ["-g","daemon off;"]
```

Run:

```bash id="qys3br"
docker run mynginx
```

Actual execution:

```bash id="5g7e2u"
nginx -g "daemon off;"
```

---

Now run:

```bash id="m1bg25"
docker run mynginx -v
```

Actual execution:

```bash id="e5q6ix"
nginx -v
```

Output:

```bash id="4fjj9h"
nginx version: nginx/1.xx
```

---

# 🔹 One-Line Understanding

| Instruction  | Simple Meaning            |
| ------------ | ------------------------- |
| `CMD`        | "Run this by default"     |
| `ENTRYPOINT` | "Always run this program" |

---

# 🔹 Real Usage Pattern

Most production containers use:

```dockerfile id="a7w2lw"
ENTRYPOINT ["application"]

CMD ["default-options"]
```

Example:

```dockerfile id="46h4bw"
ENTRYPOINT ["nginx"]

CMD ["-g","daemon off;"]
```

Because:

* nginx should always run
* but arguments can change

---

Your example is valid:

```dockerfile
FROM ubuntu:22.04

RUN apt update
RUN apt install -y nginx

COPY . /app

WORKDIR /app

ENV APP_ENV=prod

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
```

---

# 🔹 Difference Between CMD and ENTRYPOINT

| Instruction  | Purpose                                 |
| ------------ | --------------------------------------- |
| `CMD`        | Default command to run                  |
| `ENTRYPOINT` | Fixed executable/container main process |

---

# 🔹 CMD Example

```dockerfile
CMD ["nginx","-g","daemon off;"]
```

Container starts nginx by default.

You can override it:

```bash
docker run myimage bash
```

---

# 🔹 ENTRYPOINT Example

```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
```

Final executed command becomes:

```bash
nginx -g "daemon off;"
```

Now if you run:

```bash
docker run myimage -v
```

It becomes:

```bash
nginx -v
```

Because arguments append to ENTRYPOINT.

---

# 🔹 Best Practice

## Use only CMD

When:

* Simple containers
* Development/testing
* Want command override flexibility

Example:

```dockerfile
CMD ["python","app.py"]
```

---

## Use ENTRYPOINT + CMD

When:

* Container should always run a fixed application
* Production containers
* Want additional arguments support

Example:

```dockerfile
ENTRYPOINT ["python"]
CMD ["app.py"]
```

---

# 🔹 Real-World Examples

## Nginx

```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
```

---

## Python App

```dockerfile
ENTRYPOINT ["python"]
CMD ["app.py"]
```

---

## Java App

```dockerfile
ENTRYPOINT ["java","-jar"]
CMD ["app.jar"]
```

---

# 🔹 Important Rule

Avoid this together unless needed:

```dockerfile
CMD ["nginx"]
ENTRYPOINT ["python"]
```

Because ENTRYPOINT dominates execution.

---

# 🔹 Most Common Production Pattern

```dockerfile
ENTRYPOINT ["executable"]
CMD ["default_argument"]
```

Example:

```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
```
