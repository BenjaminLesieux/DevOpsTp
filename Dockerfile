FROM jenkins/jenkins:lts
LABEL authors="benjaminlesieux, gwendalRoux, thomasMariotte, pabloSanchez, loictrehin,"

USER root

# Install all the dependencies
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Switch back to Jenkins user
USER jenkins

# Install all the jenkins plugins
#RUN /usr/local/bin/install-plugins.sh \
#    blueocean \
#    nodejs

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

# Setup Jenkins configuration
COPY jenkins.yaml /usr/share/jenkins/ref/

# Setup env variables
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

WORKDIR /app

RUN git clone https://github.com/BenjaminLesieux/DevOpsTp

EXPOSE 8080

# Start jenkins
CMD ["java","-jar","/usr/share/jenkins/jenkins.war"]
