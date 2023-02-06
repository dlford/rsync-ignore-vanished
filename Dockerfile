FROM alpine:latest

RUN apk add --no-cache rsync

COPY rsync-iv /usr/local/bin/rsync-iv

CMD ["sh"]