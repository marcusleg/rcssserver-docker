# rcssserver
[RoboCup](https://www.robocup.org/) Soccer Simulator Server

## Usage
Run a throwaway container in the foreground:
```shell
docker run -it --rm -p 6000:6000 ghcr.io/marcusleg/rcssserver:latest
```

Run container in the background:
```shell
docker run -d --name rccssserver -p 6000:6000 ghcr.io/marcusleg/rcssserver:latest
```