FROM node:16-slim

RUN npm install -g @vue/cli

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f node &&\
    if getent group node ; then groupdel node; fi && \
    groupadd -g ${GROUP_ID} node && \
    useradd -l -u ${USER_ID} -g node node && \
    install -d -m 0755 -o node -g node /home/node && \
    chown --changes --silent --no-dereference --recursive \
          --from=1000:1000 ${USER_ID}:${GROUP_ID} \
        /home/node \
        /app \
    ;fi

COPY /.docker/vue/startup.sh /var/bin/startup.sh

# définit le dossier 'app' comme dossier de travail
WORKDIR /app

USER node

EXPOSE 8080

CMD ["/bin/bash", "/var/bin/startup.sh"]