package com.orm;

public class Tstu {
	private String time;
	private String ipAddr;
	private String stuAnswer;
	private String mcqID;
	private String attemptID;
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getIpAddr() {
		return ipAddr;
	}

	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	
	public String getStuAnswer() {
		return stuAnswer;
	}

	public void setStuAnswer(String stuAnswer) {
		this.stuAnswer = stuAnswer;
	}

	public String getMcqID() {
		return mcqID;
	}

	public void setMcqID(String mcqID) {
		this.mcqID = mcqID;
	}

	public String getAttemptID() {
		return attemptID;
	}

	public void setAttemptID(String attemptID) {
		this.attemptID = attemptID;
	}

}
