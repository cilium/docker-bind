# Docker bind

This is a container based on Ubuntu that has bind9 server that can be configured
using the shared folder /data.



**How to run it?**

```
docker run --rm -v /data/:/data/ -p 53:53/udp -ti eloycoto/bind
```

Any file that is on /data/ folder will be copied to `/etc/bind/` so only new
config is needed.

This container is created for testing purposes, don't use this on production
envs.
