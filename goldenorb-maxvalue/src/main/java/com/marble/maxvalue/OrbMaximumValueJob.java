package com.marble.maxvalue;

import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.goldenorb.OrbRunner;
import org.goldenorb.conf.OrbConfiguration;
import org.goldenorb.types.message.IntMessage;

public class OrbMaximumValueJob extends OrbRunner {
	public static void main(String[] args) {
		OrbMaximumValueJob omvj = new OrbMaximumValueJob();
		omvj.startJob();
	}

	private void startJob() {
		OrbConfiguration orbConf = new OrbConfiguration(true);
		orbConf.setFileInputFormatClass(TextInputFormat.class);
		orbConf.setFileOutputFormatClass(TextOutputFormat.class);
		orbConf.setVertexClass(MaximumValueVertex.class);
		orbConf.setMessageClass(IntMessage.class);
		orbConf.setVertexInputFormatClass(MaximumValueVertexReader.class);
		orbConf.setVertexOutputFormatClass(MaximumValueVertexWriter.class);
		orbConf.setNumberOfMessageHandlers(10);
		orbConf.setNumberOfVertexThreads(10);
		orbConf.setNumberOfPartitionsPerMachine(3);
		orbConf.setOrbRequestedPartitions(1);
		orbConf.setFileInputPath("/work/");
		orbConf.setFileOutputPath("/work2/");
		orbConf.setOrbClassPaths("/lib/max-value-0.0.1-SNAPSHOT.jar");
		String jobNumber = runJob(orbConf);
		System.out.println(jobNumber + "is added in queue.");
	}
}
