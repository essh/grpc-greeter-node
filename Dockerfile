FROM node:18.15.0

WORKDIR /opt/app

RUN mkdir -p /opt/grpcurl \
  && curl -L "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz" \
    | tar xvz -C /opt/grpcurl \
  && chmod +x /opt/grpcurl/grpcurl \
  && chown root:root /opt/grpcurl/grpcurl

COPY package*.json ./
RUN npm install

RUN useradd --user-group --system --home-dir /opt/app --shell /bin/bash app
USER app

COPY ./protos ./protos
COPY ./scripts ./scripts
COPY ./src ./src

EXPOSE 50051
CMD [ "node", "./src/greeter_server.js" ]
