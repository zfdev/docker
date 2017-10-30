# shadowsocks-libev

---

Image for [shadowsocks-libev][shadowsocks_libev]

[shadowsocks_libev]: https://github.com/shadowsocks/shadowsocks-libev

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
            -v <ss_config_file>:<ss_config_file_in_container>:ro \
            -e SS_CONFIG_FILE=<ss_config_file_in_container> \
            -p <host_ss_port>:<ss_port> \
            d0u9/shadowsocks-libev


2. Automatically start container after booting

    Create `/etc/systemd/system/docker-shadowsocks_libev.service`, and fill
    with the contents below:

        [Unit]
        Description=Shadowsocks libev Container
        Requires=docker.service
        After=docker.service

        [Service]
        Restart=always
        ExecStart=/usr/bin/docker start -a <container_name>
        ExecStop=/usr/bin/docker stop -t 2 <container_name>

        [Install]
        WantedBy=default.target

---


