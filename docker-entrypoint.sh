#!/bin/bash


LOGGING=$(cat <<-EOF
logging {
    category default { default_stderr; };
    category queries { default_stderr; };
};
EOF
)
echo $LOGGING >> /etc/bind/named.conf.options

cp -rfv /data/* /etc/bind/ || true

named-checkconf /etc/bind/named.conf
/usr/sbin/named -d 8 -c /etc/bind/named.conf -u bind -f
