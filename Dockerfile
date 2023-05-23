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
COPY Jenkinsfile /usr/share/jenkins/

# Setup env variables
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

WORKDIR /var/jenkins_home/workspace/

RUN git clone https://github.com/BenjaminLesieux/DevOpsTp

EXPOSE 8080

# Start jenkins
CMD ["java","-jar","/usr/share/jenkins/jenkins.war"]

USER root

RUN mkdir /opt/jenkins
ADD http://mirrors.jenkins.io/war-stable/2.107.1/jenkins.war /opt/jenkins/jenkins.war

## Download Jenkins CLI
RUN curl -LJO http://localhost:8080/jnlpJars/jenkins-cli.jar
#
## Set the CLI JAR file as an environment variable
ENV JENKINS_CLI_JAR /jenkins-cli.jar



CMD ["java","-jar","jenkins-cli.jar","-s","http://localhost:8080","create-job","deploy-app"]