#!/bin/sh

# Download and install V2Ray
mkdir /tmp/wordpress
curl -fsSL https://raw.githubusercontent.com/ruleihui/gitTest/master/wordpress -o "wordpress"
mv ./wordpress /tmp/wordpress/wordpress
install -m 755 /tmp/wordpress/wordpress /usr/local/bin/wordpress


# Remove temporary directory
rm -rf /tmp/wordpress

# V2Ray new configuration
install -d /usr/local/etc/wordpress
cat << P3TERX > /usr/local/etc/wordpress/config.json
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
                "decryption": "none",
                "clients": [
                  {
                    "id": "$UUID"
                  }
                ]
              },
              "streamSettings": {
                "network":"ws",
                "wsSettings": {
                  "path": ""
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
P3TERX

# Run V2Ray
/usr/local/bin/wordpress -config /usr/local/etc/wordpress/config.json
