#!/bin/bash
echo "
JAVA_HOME=/usr/lib/jvm/java-6-sun
export JAVA_HOME
M2_HOME=/usr/local/lib/apache-maven-3.0.3
export M2_HOME
HADOOP_HOME=/usr/local/lib/hadoop-0.20.2
export HADOOP_HOME
ZK_HOME=/usr/local/lib/zookeeper-3.3.3
export ZK_HOME
ORB_HOME=/usr/local/lib/goldenorb
export ORB_HOME

PATH=$PATH:$M2_HOME/bin:$HADOOP_HOME/bin:$ZK_HOME/bin:$ORB_HOME/src/main/resources
export PATH
" > ~/.orbrc

chmod a+rxw ~/.orbrc

echo "

. .orbrc
" >> ~/.bashrc

ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa 
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
ssh localhost -o StrictHostKeyChecking=no exit

sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"
sudo apt-get update
sudo apt-get install -y ssh
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y sun-java6-jdk 

wget http://ftp.kddilabs.jp/infosystems/apache//maven/binaries/apache-maven-3.0.3-bin.tar.gz
tar xvzf apache-maven-3.0.3-bin.tar.gz
rm apache-maven-3.0.3-bin.tar.gz
mv apache-maven-3.0.3/ /usr/local/lib/

wget http://ftp.riken.jp/net/apache//hadoop/common/hadoop-0.20.2/hadoop-0.20.2.tar.gz
tar xvzf hadoop-0.20.2.tar.gz
rm hadoop-0.20.2.tar.gz
mv hadoop-0.20.2 /usr/local/lib

wget http://www.meisei-u.ac.jp/mirror/apache/dist//zookeeper/zookeeper-3.3.3/zookeeper-3.3.3.tar.gz
tar xvzf zookeeper-3.3.3.tar.gz
rm zookeeper-3.3.3.tar.gz
mv zookeeper-3.3.3 /usr/local/lib
rm /usr/local/lib/zookeeper-3.3.3/bin/*.cmd
cp -a /usr/local/lib/zookeeper-3.3.3/conf/zoo_sample.cfg zoo.cfg
mkdir -p /export/crawlspace/mahadev/zookeeper/server1/data/
chmod a+rwx /export/crawlspace/mahadev/zookeeper/server1/data/

git clone https://github.com/raveldata/goldenorb.git
mv goldenorb /usr/local/lib
cd /usr/local/lib/goldenorb
mvn -Dmaven.test.skip=true clean package
mkdir lib
cp -a src/main/resources/orb-site.sample.xml lib/orb-site.xml
chmod a+x src/main/resources/orb-tracker.sh


