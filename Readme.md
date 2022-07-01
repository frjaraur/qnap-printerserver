## Based on https://github.com/olbat/dockerfiles/tree/master/cupsd and https://github.com/RagingTiger/cups-airprint


docker buildx build -t docker.io/frjaraur/cupsd:0.1  --push --platform=linux/arm64,linux/amd64 .


