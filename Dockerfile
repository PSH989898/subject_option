#Dockerfile 만들기
FROM nginx
COPY index.html /usr/share/nginx/html/index.html
