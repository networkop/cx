# Containerised Cumulus VX images

## Cumulus VX image

This is a containerised Cumulus VX image. 

#### Building

To build the latest stable CL version run: 

```
docker build -t networkop/cx:4.4.0 -f Dockerfile-4.4.0 .
```

To build an older version of CL, e.g. 4.3.0 run:

```
TAG=4.3.0 make build
```


#### Running

```
docker run -d --name cumulus --privileged networkop/cx:4.4.0
```


## Host image

This image is intended to be used to simulate servers. It accepts an optional integer argument that will tell the [entrypoint script](host/entrypoint.sh) to wait until that number of interfaces are connected:

#### Building 


```
cd host && docker build -t networkop/host:ifreload .
```

#### Running

Do not wait for extra interfaces to be connected:

```
docker run -d --name host --privileged networkop/host:ifreload
```

Wait for 2 extra interfaces to be connected (in addition to the default eth0):

```
docker run -d --name host --privileged networkop/host:ifreload 3
``` 


