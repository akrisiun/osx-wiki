### create Swarm

<https://nathanleclaire.com/blog/2015/06/02/docker-machine-0.3.0-sneak-preview-transmogrify-existing-servers-to-be-docker-ready-and-much-much-more/>

```
docker-machine create \
    -d generic \
    --swarm \
    --swarm-master \
    --swarm-discovery token://181a89a5589fbc7f3be78e09b585d21a \
    --generic-ip-address 107.170.195.209 \
    gendo

docker-machine create -d generic  --swarm --swarm-master \
    --swarm-discovery token://b8db8e2b18886a43e77b66c8054a6b31 \
    --generic-ip-address 192.168.1.19  --generic-ssh-user "docker" ferma1


eval $(docker-machine env ferma1)
eval $(docker-machine env --swarm ferma1)
```    