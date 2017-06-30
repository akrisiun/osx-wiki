### Docker cloud 

dockercloud
<https://cloud.docker.com/app/>

Swarms beta:
<https://cloud.docker.com/swarm/>

```
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST dockercloud/client \
       <>/cluster1
```