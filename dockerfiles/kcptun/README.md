# shadowsocks-libev

---

Image for [kcptun][kcptun_github]

[kcptun_github]: https://github.com/xtaci/kcptun

## Install

1. From DockerHUB

        docker pull d0u9/shadowsocks-libev

2. From DockerFile

        cd /tmp
        docker build -f </path/to/Dockerfile> -t shadowsocks-libev .

## Usage

1. Run container

        docker run -d \
            --name <container_name> \
            --network <network> \
            -e CMD=[client|server] \
            -v <kcp_config_file>:<kcp_config_file_in_container>:ro \
            -e KCP_CONFIG_FILE=<kcp_config_file_in_container> \
            -p <host_kcp_port>:<kcp_port> \
            d0u9/kcptun

2. Automatically start container after booting

    Create `/etc/systemd/system/docker-kcptun.service`, and fill
    with the contents below:

        [Unit]
        Description=Shadowsocks and kcptun Container
        Requires=docker.service
        After=docker.service

        [Service]
        Restart=always
        ExecStart=/usr/bin/docker start -a <container_name>
        ExecStop=/usr/bin/docker stop -t 2 <container_name>

        [Install]
        WantedBy=default.target

---


