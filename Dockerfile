# This is the TLS to this day
FROM jenkins/jenkins:2.302

# Switching to root to install some stuff
USER root

# Installing docker repository
RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list && \
      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
      apt-get update && \
      apt-get install -y \
        sudo \
        docker-ce docker-ce-cli containerd.io \
        python3-pip && \
      pip3 install \
        awscli

# Setting jenkins as a sudoer
RUN     usermod -aG docker jenkins && \
        echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER jenkins
