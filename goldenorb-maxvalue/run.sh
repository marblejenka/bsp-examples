#!/bin/bash
mvn -Dmaven.test.skip=true clean package
cp -a target/*.jar $ORB_HOME/lib
cd $ORB_HOME

hadoop fs -rmr /work
hadoop fs -rmr /work2
hadoop fs -mkdir /work
hadoop fs -mkdir /work2
hadoop fs -put data/input.txt /work

java -cp lib/*:target/org.goldenorb.core-0.1.0-SNAPSHOT-jar-with-dependencies.jar com.marble.maxvalue.OrbMaximumValueJob
