FROM ubuntu:14.04
MAINTAINER Manuel Toledo <mtoledo@adobe.com>

# Use in multi-phase builds, when an init process requests for the container to gracefully exit, so that it may be committed
# Used with alternative CMD (worker.sh), leverages supervisor to maintain long-running processes
ENV DEBIAN_FRONTEND=noninteractive \
    SIGNAL_BUILD_STOP=99 \
    # CONTAINER_ROLE=web \
    CONTAINER_PORT=8080 \
    NOT_ROOT_USER=www-data \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_KILL_FINISH_MAXTIME=5000 \
    S6_KILL_GRACETIME=3000 \
    LANG=C.UTF-8 \
    APP_ROOT=/app

RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    # Install pre-reqs \
    apt-get update && \
    apt-get upgrade -yqq && \
    apt-get -yqq  install \
      software-properties-common \
    && \
    # Install python2.7 from a PPA
    add-apt-repository ppa:fkrull/deadsnakes-python2.7 && \
    apt-get update && \
    apt-get upgrade -yqq && \
    apt-get -yqq install \
      python2.7 \
      python-pip \
      python2.7-dev \
    && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    apt-get remove --purge -yq \
      software-properties-common \
      manpages \
      manpages-dev \
      man-db \
      patch \
      make \
      unattended-upgrades \
    && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/{cache,log}/ && \
    rm -rf /tmp/* /var/tmp/*

ENV LC_ALL=en_US.UTF-8

COPY ./container/root /

# Add S6 overlay build, to avoid having to build from source
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    rm /tmp/s6-overlay-amd64.tar.gz

EXPOSE ${CONTAINER_PORT}

# NOTE: intentionally NOT using s6 init as the entrypoint
# This would prevent container debugging if any of those service crash
CMD ["/bin/bash", "/run.sh"]
