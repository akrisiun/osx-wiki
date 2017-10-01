#!/bin/sh

# cd /docs/
# mkdocs serve --dev-addr=0.0.0.0:8000 &

pwd
docker run -d -p 0.0.0.0:8008:8000 -v /Users/andriusk/Beta/darwin/osx-wiki/mkdocs:/docs  --name md8008 akrisiun/mkdocs

docker run -d -p 0.0.0.0:8080:8000 -v /Users/andriusk/Sites/osx-wiki/mkdocs:/docs  --name md8080 akrisiun/mkdocs
docker logs md8080