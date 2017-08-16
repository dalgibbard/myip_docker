# myip_docker
A docker container which returns a requestors IP address
Page is PHP, run in lighttpd, in alpine, to keep the image tiny (~20MB).
Also configured to log out to docker logs output.

## Build
```
docker build -t myip .
```

## Run
```
docker run --name "myip" -p 80:80 myip
```

## Call
Note: Naturally, calling this locally will give a local IP :)
```
curl http://localhost:80/
```
