FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
RUN mkdir /usr/share/nginx/html/test
COPY ./index.html /usr/share/nginx/html/test
COPY ./default.conf /etc/nginx/conf.d/
