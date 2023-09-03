FROM alpine:latest

RUN apk update && \
    apk upgrade

RUN apk add git

WORKDIR /script

COPY . .

ENTRYPOINT [ "./auto-contributions.sh" ]