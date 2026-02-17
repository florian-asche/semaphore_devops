# Use Ubuntu latest
FROM ubuntu:24.04

# Give image some infos
LABEL name="semaphore_devops"
LABEL maintainer="Florian Asche <devops@florian-asche.de>"

# Settings for build
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# Run everything as root user
USER root

# Add ansible user and group
RUN useradd -rm -d /home/devops -s /bin/bash -g root -G sudo -u 1337 devops 

# Install common package for apt-add-repository
RUN apt-get update -y -qq && \
    apt-get install -y -qq software-properties-common

# Add ansible ppa
RUN apt-add-repository -y ppa:ansible/ansible

# Install base packages
RUN apt-get -y -qq update && \
    apt-get -y -qq upgrade

# Install multiple packages
RUN apt-get -y -qq install \
        apt-transport-https \
        software-properties-common \
        locales \
        sudo \
        wget \
        curl \
        cron \
        git \
        mc \
        net-tools \
        iputils-ping \
        dnsutils \
        nmap \
        sshpass \
        unar \
        cifs-utils \
        vim \
        htop \
        mtr \
        smbclient \
        openssh-server \
        unzip \
        gpg \
        supervisor \
        zsh

# Setup SSH
RUN ssh-keygen -A
# TODO: das kann ggf. besser einmalig passieren und sollte in einem custom FS landen
RUN mkdir -p /run/sshd

# Install python
RUN apt-get -y -qq install \
        #python2 \
        #python-pip \
        python3 \
        python3-pip

# Install Ansible
RUN apt-get -y -qq install ansible ansible-lint
# Check Ansible version
RUN ansible --version

# Install powershell
RUN source /etc/os-release && wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get -y -qq update && \
    apt-get -y -qq install powershell

# Install additional needed python packages
RUN apt-get -y -qq install python3-pyyaml-env-tag python3-netaddr python3-jmespath python3-passlib python3-docker python3-jinja2 python3-httplib2 python3-boto python3-requests python3-urllib3
#RUN pip install --no-cache-dir --upgrade PyYAML Jinja2 httplib2 boto requests urllib3

# Install vscode-server
#RUN wget https://github.com/coder/code-server/releases/download/v4.6.0/code-server_4.6.0_amd64.deb
#RUN apt -y install ./code-server_4.6.0_amd64.deb

# Install semaphore
RUN wget https://github.com/semaphoreui/semaphore/releases/download/v2.16.51/semaphore_2.16.51_linux_amd64.deb
RUN sudo dpkg -i semaphore_2.16.51_linux_amd64.deb
RUN rm semaphore_2.16.51_linux_amd64.deb

# Cleanup
RUN apt-get -qq clean

# Install supervisor for multiple processes
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Define startcommand
WORKDIR /home/semaphore
USER root
EXPOSE 22

#ENTRYPOINT ["/bin/bash"]
#CMD ["/usr/bin/supervisord -c /etc/supervisor/supervisord.conf"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
# wenn mich nicht alles täuscht, dann wird der prozess auch durch systemd oder sowas gestartet?
# ssh server
# semaphore
