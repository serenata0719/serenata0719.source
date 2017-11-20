FROM node:9.2.0-alpine
RUN apk update && apk add --no-cache git
RUN npm install -g hexo-cli && mkdir -p /source
COPY /source /source
RUN git config --global user.email "592627609@qq.com"
RUN git config --global user.name "serenata0719" 
RUN cd /source && npm install hexo && hexo d