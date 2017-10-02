FROM jenkins/jenkins:2.78

# Needed to install tools with apt-get
USER root

# Install tools.
RUN apt-get update && apt-get install -y \
        default-jre \
        vim \
        openssh-client \
        sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install docker-cli
ENV DOCKER_CLI_VERSION 17.04.0-ce
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_CLI_VERSION}.tgz \
    && tar xzvf docker-${DOCKER_CLI_VERSION}.tgz \
    && mv docker/docker /usr/local/bin \
    && rm -r docker docker-${DOCKER_CLI_VERSION}.tgz

# Install kubectl
ENV KUBECTL_VERSION 1.7.2
RUN curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/bin/kubectl \
    && kubectl version --client
ENV KUBECTL_HOME /usr/bin/kubectl
ENV PATH $KUBECTL_HOME:$PATH

# Install node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install angular-cli
ENV ANGULAR_CLI_VERSION 1.3.2
RUN npm install -g @angular/cli@${ANGULAR_CLI_VERSION}

# Install google-chrome-stable for frontend unit testing & e2e testing
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update && apt-get install -y google-chrome-stable \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install predefined Jenkins plugins.
COPY config/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Give jenkins user passwordless sudo
RUN echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Replace the docker binary with a sudo script so jenkins user can perform sudoless docker commands
# From: https://github.com/psharkey/docker/blob/master/jenkins-dood/Dockerfile
RUN mv /usr/local/bin/docker /usr/local/bin/docker.bin \
    && printf '#!/bin/bash\nsudo docker.bin "$@"\n' > /usr/local/bin/docker \
	&& chmod +x /usr/local/bin/docker

# Add some handy aliases for all users
RUN echo "alias ll='ls -al'" >> /etc/bash.bashrc \
    && echo "alias k='kubectl'" >> /etc/bash.bashrc \
    && echo "alias d='docker'" >> /etc/bash.bashrc

# Switch to user Jenkins.
USER jenkins

# Set JVM options and prevent Jenkins setup wizard from showing up.
ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m"
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Set jenkins context path to match Kubernetes ingress
ENV JENKINS_OPTS --prefix=/jenkins