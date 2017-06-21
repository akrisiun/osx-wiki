### Docker

```
docker run -d -p 0.0.0.0:8002:8000 -v c:\Work_Exe\docs:/docs  --name md8002 akrisiun/mkdocs
docker logs md8002
# Success!!!!

@powershell
ps>
netstat -atn -p TCP | findstr "ESTA"

docker run -p 8002:8000 -v c:\Work_Exe\docs2:/docs        --name md8002 akrisiun/mkdocs
docker run -p 8002:8000 -v d:\Sanitex\Exchange\Docs:/docs --name md8002 akrisiun/mkdocs

docker run -it -p 8002:8000 -v d:\Sanitex\Exchange\Docs:/docs --name md8002 akrisiun/mkdocs


docker run -it -p 8001:8000 -v c:\Work_Exe\docs:/docs --name md3 akrisiun/mkdocs1
docker exec -it md3 /bin/sh
docker exec md3 mkdocs serve --dev-addr=0.0.0.0:8000



env
export http_proxy=http://???:3128

sudo nano /etc/apt/apt.conf
Acquire::http::Proxy "http://???:3128";
```

## SVG Code 

![Alt text](https://rawgithub.com/potherca/StackOverflow/gh-pages/question.13808020.include-an-svg-hosted-on-github-in-markdown/controllers_brief.svg)
<img src="https://rawgithub.com/potherca/StackOverflow/gh-pages/question.13808020.include-an-svg-hosted-on-github-in-markdown/controllers_brief.svg">
Result

## PROXY SNTX

```
ENV http_proxy ${http_proxy}
set http_proxy=http://???:3128/

docker build --build-arg http_proxy=http://???:3128/ .
docker tag 69c60d49cf53 mkdocs1 

docker run -it -p 8001:8000 -v d:\VM\docker\mkdocs\docs:/docs --name  md2 mkdocs1
docker run -it -p 8001:8000 -v c:\Work_Exe\docs:/docs --name  md3 mkdocs1

docker run -v d:/data:/data alpine ls /data

#pip / docs 

pip install -e .[tests,docs]
```