@ECHO port 8000

docker run -d -p 0.0.0.0:8000:8000 -v D:\Beta\osx-wiki\mkdocs:/docs  --name md8000 akrisiun/mkdocs