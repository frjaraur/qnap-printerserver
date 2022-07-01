# Simple Cupsd for QNAP.

>Note: This repository is based on https://github.com/olbat/dockerfiles/tree/master/cupsd and https://github.com/RagingTiger/cups-airprint works. Many Thanks both!!.

```
$ docker buildx build -t docker.io/frjaraur/cupsd:0.1  --push --platform=linux/arm64,linux/amd64 .
```

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

```
$ docker run \
       -d \
       --name=printsrv \
       --net=host \
       -v /var/run/dbus:/var/run/dbus \
       --device /dev/bus \
       --device /dev/usb \
       -e CUPSPASSWORD="admin" \
       docker.io/frjaraur/cupsd:0.1
```