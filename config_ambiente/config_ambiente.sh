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
