FROM registry.access.redhat.com/ubi8-minimal AS build-env

RUN microdnf install -y tar gzip

COPY keycloak-18.0.2.tar.gz /tmp/keycloak/

# The next step makes it uniform for local development and upstream built.
# If it is a local tar archive then it is unpacked, if from remote is just downloaded.
RUN (cd /tmp/keycloak && \
    tar -xvf /tmp/keycloak/keycloak-*.tar.gz && \
    rm /tmp/keycloak/keycloak-*.tar.gz) || true

RUN mv /tmp/keycloak/keycloak-* /opt/keycloak && mkdir -p /opt/keycloak/data \
    && mkdir -p /opt/keycloak/cert \
    && mkdir -p /var/log/keycloak

RUN chmod -R g+rwX /opt/keycloak
RUN chmod -R g+rwX /var/log/keycloak

# FROM registry.access.redhat.com/ubi8-minimal
# ENV LANG en_US.UTF-8
COPY docker-entrypoint.sh /opt/keycloak/docker-entrypoint.sh
RUN chmod +x /opt/keycloak/docker-entrypoint.sh

# COPY keycloak.conf.sh /opt/keycloak/keycloak.conf.sh
# RUN chmod +x /opt/keycloak/keycloak.conf.sh && /opt/keycloak/keycloak.conf.sh > /opt/keycloak/conf/keycloak.conf


RUN chown 1000:0 /opt/keycloak
RUN chown 1000:0 /var/log/keycloak
# COPY --from=build-env --chown=1000:0 /opt/keycloak /opt/keycloak

RUN microdnf install -y --nodocs java-11-openjdk-headless glibc-langpack-en && microdnf clean all && rm -rf /var/cache/yum/* && \
    echo "keycloak:x:0:root" >> /etc/group && \
    echo "keycloak:x:1000:0:keycloak user:/opt/keycloak:/sbin/nologin" >> /etc/passwd

USER 1000

EXPOSE 8080
EXPOSE 8443


RUN /opt/keycloak/docker-entrypoint.sh