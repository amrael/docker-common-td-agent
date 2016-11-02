# FROM instruction must be the first and it's impossible to use the ENV as a tag at the moment.
FROM debian:jessie
ENV DEBIAN_TAG jessie

# td-agent common
RUN apt-get update \
    && apt-get install -y wget \
    && mkdir -p /var/lib/fluentd /etc/td-agent/conf.d \
    && echo "deb http://packages.treasuredata.com/2/debian/$DEBIAN_TAG/ $DEBIAN_TAG contrib" > /etc/apt/sources.list.d/treasure-data.list \
    && wget --quiet -O - https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - \
    && apt-get update \
    && apt-get install -y --force-yes td-agent
COPY td-agent.conf /etc/td-agent/td-agent.conf

EXPOSE 24224

CMD ["td-agent"]
