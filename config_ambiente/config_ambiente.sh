#Instalação Java Ubuntu:
apt update
apt install default-jdk


#Download e inst. do Eclipse:
cd ~/Downloads && wget https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2020-12/R/eclipse-inst-jre-linux64.tar.gz
tar xfz ~/Downloads/eclipse-inst-jre-linux64.tar.gz
~/Downloads/eclipse-installer/eclipse-inst


#Instl. Maven:
cd ~/Downloads && wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
#ou
apt install maven
maven -version


#Container Tomcat:
docker run \
  --name tomcat \
  -it \
  -d \
  --restart unless-stopped \
  -p 8989:8080 \
  -v /home/ilhanublar/dev/jenkins-lab-udemy/config_ambiente/tomcat/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml \
  -v /home/ilhanublar/dev/jenkins-lab-udemy/config_ambiente/tomcat/context.xml:/tmp/context.xml \
  tomcat:8.5.51 \
  /bin/bash -c "mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2; mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps; cp /tmp/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml; catalina.sh run"
#http://localhost:8989/


#Database:
docker run --name pg-tasks -d -e POSTGRES_DB=tasks -e POSTGRES_PASSWORD=password -p 5433:5432 --restart unless-stopped postgres:9.6


#Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


#Clone Backend:
git clone https://github.com/guilhermemaas/tasks-backend.git


#Configurar várias versões do Java:
#https://linuxize.com/post/install-java-on-ubuntu-18-04/
sudo update-alternatives --config java

#Instalar o java 8.

#Ajustar o IP do banco com o IP do container do Postgres.
docker container inspect 3a0 | grep IP

#/main/resources/application.properties:
spring.datasource.url=jdbc:postgresql://${DATABASE_HOST:IP_DOCKER_MACHINE}:${DATABASE_PORT:5433}/tasks

#Build:
cd ~/dev/tasks-backend/
mvn package
#[INFO] Replacing main artifact with repackaged archive                                             
#[INFO] ------------------------------------------------------------------------
#[INFO] BUILD SUCCESS                                                           
#[INFO] ------------------------------------------------------------------------
#[INFO] Total time:  02:39 min                                                  
#[INFO] Finished at: 2020-12-30T11:18:00-03:00                                  
#[INFO] ------------------------------------------------------------------------
cd /target
ls tasks-backend.war

http://localhost:8989/manager/html
WAR file to deploy

#Configurar várias versões do Java:
#https://linuxize.com/post/install-java-on-ubuntu-18-04/
sudo update-alternatives --config java


#Clone Frontend:
git clone https://github.com/guilhermemaas/tasks-frontend.git
#Lembrar de alterar os applications-properties das aplicações.
#http://localhost:8989/tasks/


#Jenkins
docker run \
  --name jenkins-blueocean \
  --restart unless-stopped \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8000:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  jenkinsci/blueocean:latest

#Ao realizar o primeiro login o Jenkins vai pedir o admin password. Basta pegar no container:
docker exec -it ce9 cat /var/jenkins_home/secrets/initialAdminPassword 


#Na interface web: Manage Jenkins > Global Tool Configuration
#Export do JAVA_HOME onde vai rodar as tasks do Jenkins:
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

#Maven Home:
/usr/share/maven


#Criando um node:
mkdir /var/jenkins #-> Root directory.


#Rodar o jenkins node:
wget http://localhost:8000/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://localhost:8000/computer/nublar-desktop/slave-agent.jnlp -secret 83c44ff1b7d11f85f551f8cd16d8ea834f9c607d5564ae18379b698fb163d61c -workDir "/var/jenkins"


#SonarQube - 
https://hub.docker.com/_/sonarqube/
#Verificar o item "Docker Host Requirements".
#Adicionado ao docker-compose.yml do projeto.
http://localhost:9000
#admin/admin
#No Jenkins instalar 2 plugins: Sonarqube e Sonarqube Quality Gate

#SonarQube Scanner:
#No node que vai rodar:
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip
unzip sonar...
#Adicionar o caminho em: Jenkins > Global Tool Configuration > SonarQube Scanner