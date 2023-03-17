FROM fullstorydev/grpcurl:v1.8.7 as grpcurl

FROM node:18.15.0

COPY --from=grpcurl /bin/grpcurl /usr/local/bin/grpcurl

WORKDIR /opt/app

COPY package*.json ./
RUN npm install

RUN useradd --user-group --system --home-dir /opt/app --shell /bin/bash app
USER app

COPY ./protos ./protos
COPY ./scripts ./scripts
COPY ./src ./src

EXPOSE 50051
CMD [ "node", "./src/greeter_server.js" ]
