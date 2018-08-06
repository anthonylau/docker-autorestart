# Auto Restart Docker Container

Auto restart unhealthy containers base on healthcheck

# Setup

1. Label your container with `-l io.github.anthonylau.docker-autorestart=true`
2. Run this container with `-v /var/run/docker.sock:/var/run/docker.sock`
