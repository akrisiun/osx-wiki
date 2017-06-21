#!/bin/sh

# cd /docs/
# mkdocs serve --dev-addr=0.0.0.0:8000 &

pwd
docker run -d -p 0.0.0.0:8000:8000 -v /Users/andriusk/Sites/osx-wiki:/docs  --name md8000 akrisiun/mkdocs
