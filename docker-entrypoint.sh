#!/bin/bash


CONFIG=$(cat <<-EOF
options {
        directory "/var/cache/bind";
        dnssec-validation auto;
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};

logging {
    category default { default_stderr; };
    category queries { default_stderr; };
};
EOF
)

chmod 777 /etc/bind
echo -n "$CONFIG" > /etc/bind/named.conf.options
cp -rfv /data/* /etc/bind/ || true

if [ -n "${DNSSEC_DOMAIN}" ]; then
    echo "Creating certificates for '${DNSSEC_DOMAIN}'"

    mkdir -p -m777 /etc/bind/keys
    cd /etc/bind/keys

    dnssec-keygen ${DNSSEC_DOMAIN}
    dnssec-keygen -fk ${DNSSEC_DOMAIN}
    chown bind /etc/bind/keys/*
fi

named-checkconf /etc/bind/named.conf
/usr/sbin/named -d 8 -c /etc/bind/named.conf -u bind -f
