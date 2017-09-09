# RhodeCode Control

Dockerfile for RhodeCode Control, ready-to-go for VCS Server, RhodeCode CE and EE.

```bash
docker run -it ckulka/rhodecode-rccontrol
```

## Complete Stack

The following `docker-compose.yaml` file spins up a complete RhodeCode stack

```yaml
version: "3"

services:
  vcsserver:
    image: ckulka/rhodecode-vcsserver

  db:
    image: postgres:alpine
    environment:
      POSTGRES_PASSWORD: cookiemonster

  rhodecode:
    image: ckulka/rhodecode-ce
    environment:
      RC_USER: admin
      RC_PASSWORD: ilovecookies
      RC_EMAIL: adalovelace@example.com
      RC_DB: postgresql://postgres:cookiemonster@db
      RC_CONFIG: |
        [app:main]
        vcs.server = vcsserver:9900
    ports:
      - "5000:5000"
```