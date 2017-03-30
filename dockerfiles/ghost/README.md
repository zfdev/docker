# ghost

---

A simple, powerful publishing platform [https://ghost.org](https://ghost.org)

## Install

1. From DockerHUB

        docker pull d0u9/ghost

    For china users, aliyun docker repo is more preferable:

        docker pull registry.cn-hangzhou.aliyuncs.com/master/ghost


2. From DockerFile

        cd /tmp
        docker build -f </path/to/Dockerfile> -t shadowsocks-libev .

## Usage

1. Run container

        docker run -d \
            --name <container_name> \
            -p <host_port>:2368 \
            -v <content_dir>:/var/lib/ghost \
            -e PUID=<uid> \
            -e PGID=<gid> \
            d0u9/ghost

2. Automatically start container after booting

    Create `/etc/systemd/system/docker-ghost.service`, and fill with content below:

        [Unit]
        Description=container for ghost platform
        Requires=docker.service
        After=docker.service

        [Service]
        Restart=always
        ExecStart=/usr/bin/docker start -a <container_name>
        ExecStop=/usr/bin/docker stop -t 2 <container_name>

        [Install]
        WantedBy=default.target

## Note

    If environment variables `-e PUID=<uid>` and `-e PGID=<gid>` are set, ghost
    will be run as `$PUID:$PGID`, and the owner of `/var/lib/ghost` directory
    is changed accordingly as well. `nobody:nogroup` is the default user and
    group if these two variables are not set explicitly.

    If the content dir user mounted to /var/lib/ghost is an empty directory,
    ghost image will create needed directories and files. If it is not empty,
    nothing will be created but the owner of the directory will be set to
    `$PUID:$PGID`.

---


