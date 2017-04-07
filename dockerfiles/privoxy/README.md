# deluge-web

---

## Install

1. From DockerHUB

        docker pull d0u9/privoxy

    For china users, use aliyun docker mirror instead:

        docker pull registry.cn-hangzhou.aliyuncs.com/master/privoxy

2. From DockerFile

        cd /tmp
        docker build -f </path/to/Dockerfile> -t privoxy .

## Usage

1. Run container

        docker -d \
            --name <container_name> \
            -e CONFIG_FILE=<config_file> \
            -v <host_volumn>:<config_file> \
            -p <host_port>:<container_port> \
            privoxy

2. Automatically start container after booting

    Create `/etc/systemd/system/docker-privoxy.service`, and fill with content below:

        [Unit]
        Description=HTTP proxy
        Requires=docker.service
        After=docker.service

        [Service]
        Restart=always
        ExecStart=/usr/bin/docker start -a <container_name>
        ExecStop=/usr/bin/docker stop -t 2 <container_name>

        [Install]
        WantedBy=default.target

## Note

If the shadowsocks client to which provixy forwards traffic runs in another
container, use `--link` option to add privoxy container to the network of
shadowsocks container. The container name is the host name which can be visited
directly.

---


