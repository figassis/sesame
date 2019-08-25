FROM alpine:3.2
MAINTAINER Cagatay Gurturk <cguertuerk@ebay.de>

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*
RUN mkdir /root/.ssh && chmod -R 600 /root/.ssh 

CMD cat /root/ssh/crypto && cat /root/ssh/config && \
    rm -rf /root/.ssh && mkdir /root/.ssh && \
    cat /root/ssh/crypto > /root/.ssh/crypto && \
    cat /root/ssh/config > /root/.ssh/config && \
    chmod -R 600 /root/.ssh/* && \
    ssh -vv -o StrictHostKeyChecking=no -N $TUNNEL_HOST -L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
    && while true; do sleep 30; done;
EXPOSE 1-65535