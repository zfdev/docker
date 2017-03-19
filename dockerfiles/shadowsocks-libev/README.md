# shadowsocks-libev

---

## Install

1. From DockerHUB

        docker pull d0u9/shadowsocks-libev

    For china users, aliyun docker repo is more preferable:

        docker pull registry.cn-hangzhou.aliyuncs.com/master/shadowsocks-libev


2. From DockerFile

        cd /tmp
        docker build -f </path/to/Dockerfile> -t shadowsocks-libev .

## Usage

1. Run container

        docker run -d \
            --name <container_name> \
            -p 1080:1080 \
            -v <dir_contains_config_json>:<config_file_in_docker> \
            -e CONFIG_FILE=<config_file_in_docker> \
            shadowsocks-libev

2. Automatically start container after booting

    Create `/etc/systemd/system/docker-shadowsocks_libev.service`, and fill with content below:

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

3. Set your browser's proxy to `IP:1080`, and enjoy it.

---


