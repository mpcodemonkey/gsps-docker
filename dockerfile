FROM eclipse-temurin:17-jdk-alpine as development
RUN  \
     # Install json utilities for config.json, TODO: remove git after zip function in gc finished and nodejs, procps used for ps monitors
     apk add --no-cache nodejs git curl procps &&\
     cd /usr/bin/ && curl -L https://github.com/trentm/json/raw/master/lib/json.js > json && chmod 755 json

# Web (https 443) (http 80) (Game 22102)
EXPOSE 443 80 22102

# Add User
RUN addgroup --system gsps && adduser -S -s /bin/false -G gsps gsps

# Sweet Home Alabama :)
WORKDIR /home/gsps
COPY --chown=gsps:gsps run_gc.sh ./

# Get latest release of GrasscutterQuests from our release repo
RUN curl -L https://github.com/mpcodemonkey/GC-Base/releases/download/1.0/grasscutter.zip > grasscutter.zip
Run unzip grasscutter.zip

# Run a script to copy the actual config into the current directory, then run grasscutter. WA until we modify GC to accept a config path
ENTRYPOINT ["sh", "./run_gc.sh"]