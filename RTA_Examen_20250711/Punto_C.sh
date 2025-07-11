# desde UTN-FRA_SO_Examenes/202411/docker/web 

vim index.html

# desde UTN-FRA_SO_Examenes/202411/docker
docker compose up -d
docker build -t lucastissera/web2-tissera .
cat >> Dockerfile
FROM nginx:latest
COPY ./web /usr/share/nginx/html


# desde UTN-FRA_SO_Examenes/202411/docker/web/file/
cat info.txt
Nombre de usuario: lucastissera
ID de usuario : 1002
Hash del usuario: ltissera:$y$j9T$x8XL971VV0w0lhIREdO5M0$N/4/Jy/wvM8fu4DaAKRB6XRwgwLu/3d/W.mY9pHUVf0:20279:0:99999:7:::


