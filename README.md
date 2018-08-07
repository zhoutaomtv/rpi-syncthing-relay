
基于https://hub.docker.com/r/kylemanna/syncthing-relay/，将基础镜像更换为ARM32V6下面对应的进行编译生成

Syncthing: 0.14.49


##  Quick Start
###  Just run:

```

docker run --rm -p 22067:22067 -p 22070:22070 zhoutaomtv/rpi-syncthing-relay

```
Verify your server shows up at http://relays.syncthing.net/

###  Or private relay:

```

docker run --rm -p 22067:22067 -p 22070:22070 zhoutaomtv/rpi-syncthing-relay -pools=""

```
