package com.orm;

public class Tquiz {
	
	public String quizID;
	public String attemptID;
	public String quizName;
	public String className;
	public String attemptCreatetime;
	public String attemptComment;
	public String attemptURL;
	
	public String classID;
	public String status;
	public String moduleID;
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getclassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}
	public String getmoduleID() {
		return moduleID;
	}

	public void setModuleID(String moduleID) {
		this.moduleID = moduleID;
	}
	

	public String getQuizID() {
		return quizID;
	}

	public void setQuizID(String quizID) {
		this.quizID = quizID;
	}

	public String getAttemptID() {
		return attemptID;
	}

	public void setAttemptID(String attemptID) {
		this.attemptID = attemptID;
	}

	public String getQuizName() {
		return quizName;
	}

	public void setQuizName(String quizName) {
		this.quizName = quizName;
	}
	
	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getAttemptCreatetime() {
		return attemptCreatetime;
	}

	public void setAttemptCreatetime(String attemptCreatetime) {
		this.attemptCreatetime = attemptCreatetime;
	}

	public String getAttemptComment() {
		return attemptComment;
	}

	public void setAttemptComment(String attemptComment) {
		this.attemptComment = attemptComment;
	}

	public String getAttemptURL() {
		return attemptURL;
	}

	public void setAttemptURL(String attemptURL) {
		this.attemptURL = attemptURL;
	}

}
