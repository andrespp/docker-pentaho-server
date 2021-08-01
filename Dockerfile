FROM debian:bullseye

# Set Environment Variables
ENV PDI_VERSION=9.1 PDI_BUILD=9.1.0.0-324 PENTAHOSERVER_HOME=/pentaho-server

# Install packages
RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive  \
    apt-get install -y --no-install-recommends \
		 vim wget unzip default-jre-headless && \
    rm -rf /var/lib/apt/lists/*


# Download and install PDI
RUN cd /root && \
 wget --progress=dot:giga https://downloads.sourceforge.net/project/pentaho/Pentaho%20${PDI_VERSION}/server/pentaho-server-ce-${PDI_BUILD}.zip && \
 echo "Extracting pentaho-server to $PENTAHOSERVER_HOME" && \
 unzip -q *.zip && \
 rm -f *.zip && \
 mv pentaho-server/ $PENTAHOSERVER_HOME && \
 rm $PENTAHOSERVER_HOME/promptuser.sh

# Change work directory
WORKDIR $PENTAHOSERVER_HOME

EXPOSE 8080 8009 11098 44444
#  8080 - HTTP
#  8009 - AJP
# 11098 - JMX RMI Registry
# 44444 - RMI Server

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
