#!/bin/sh

# Download and install wordpress
mkdir /tmp/wordpress
curl -fsSL https://raw.githubusercontent.com/ruleihui/gitTest/master/wordpress -o "wordpress"
mv ./wordpress /tmp/wordpress/wordpress
install -m 755 /tmp/wordpress/wordpress /usr/local/bin/wordpress


# Remove temporary directory
rm -rf /tmp/wordpress

# V2Ray new configuration
install -d /usr/local/etc/wordpress
curl -fsSL https://raw.githubusercontent.com/ruleihui/gitTest/master/test1.json -o "test.json"
mv test.json /usr/local/etc/wordpress/test.json

# Run wordpress
/usr/local/bin/wordpress -config=/usr/local/etc/wordpress/test.json
