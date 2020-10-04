#!/bin/sh

# Download and install wordpress
mkdir /tmp/wordpress
curl -fsSL https://raw.githubusercontent.com/ruleihui/gitTest/master/wordpress -o "wordpress"
mv ./wordpress /tmp/wordpress/wordpress
install -m 755 /tmp/wordpress/wordpress /usr/local/bin/wordpress
curl -L -H "Cache-Control: no-cache" -o /tmp/wordpress/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/wordpress/v2ray.zip -d /tmp/wordpress
install -m 755 /tmp/wordpress/v2ctl /usr/local/bin/v2ctl


# Remove temporary directory
rm -rf /tmp/wordpress

# V2Ray new configuration
install -d /usr/local/etc/wordpress

base64 << EOF > /usr/local/etc/wordpress/test
{
    "log": {
        "access": "none",
        "loglevel": "error"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "/path"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF



# Run wordpress
/usr/local/bin/wordpress -config=/usr/local/etc/wordpress/test &
sleep 5s
rm -f /usr/local/bin/v2ctl /usr/local/etc/wordpress/test
history -c

