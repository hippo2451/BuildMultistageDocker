FROM ubuntu:20.04 as site1
LABEL maintaner="hippo245"
WORKDIR /var
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  git
RUN git clone https://github.com/daviddias/static-webpage-example.git ./static-webpage-example

FROM site1 as siteapache
EXPOSE 80
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
RUN cp -a ./static-webpage-example/src/* /var/www/html/
CMD ["apachectl", "-D", "FOREGROUND"]


FROM site1 as sitenginx
EXPOSE 80
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx
RUN cp -a ./static-webpage-example/src/* /var/www/html/
CMD ["nginx", "-g", "daemon off;"]
