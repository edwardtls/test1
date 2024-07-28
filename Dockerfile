FROM jenkins/jenkins:jdk21
USER root
RUN apt-get clean autoclean
RUN apt-get update
RUN apt-get install -y  netcat-openbsd && apt-get clean
RUN mkdir /var/jenkins_home/.ssh && chown 1000:1000 /var/jenkins_home/.ssh
USER jenkins
ENV JAVA_OPTS='-Djenkins.install.runSetupWizard=false'
ENV NODE_OPTIONS='--dns-result-order=ipv4first'
COPY plugins.txt /usr/share/jenkins/ref/
COPY .ssh /usr/share/jenkins/ref/
RUN jenkins-plugin-cli --plugins -f /usr/share/jenkins/ref/plugins.txt
