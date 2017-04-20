# shadowsocks-libev

---

This image aims to easy the depolyment of shadowsocks on both server and client.
kcptun is included as well for people who want to benefit from the kcp protocol.

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
            -e CMD=[client|server] \
            -v <ss_config_file>:<ss_config_file_in_container>:ro \
            -e SS_CONFIG_FILE=<ss_config_file_in_container> \
            -p <host_ss_port>:<ss_port> \
            -e ENABLE_KCP=true \
            -v <kcp_config_file>:<kcp_config_file_in_container>:ro \
            -e KCP_CONFIG_FILE=<kcp_config_file_in_container> \
            -p <host_kcp_port>:<kcp_port> \
            d0u9/shadowsocks-libev

    To depoly this image as server, assign `server` to the `cmd` environment.
    Similarly, assigning `client` to `cmd` will depoly this image as a shadowsocks
    client.

    To disable the kcp function in this image, simply ignore the `enable_kcp`
    environment variable.

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


