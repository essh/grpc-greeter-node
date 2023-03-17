#!/bin/bash

exec /usr/local/bin/grpcurl -plaintext -import-path /opt/app/protos -proto helloworld.proto localhost:50051 helloworld.Greeter/SayHello
