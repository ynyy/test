package com.orm;

public class Tanswer {

	public String mcqID;
	public String quizID;
	public String attemptID;
	public String mcqTitle;
	public String optionA;
	public String optionB;
	public String optionC;
	public String optionD;
	public String crtAnswer;
	
	public String cntOfOptionA;
	public String cntOfOptionB;
	public String cntOfOptionC;
	public String cntOfOptionD;
	
	public String correctRatio;
	public String correctTimes;
	public String totalTimes;
	
	private String url;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getCorrectRatio() {
		return correctRatio;
	}

	public void setCorrectRatio(String correctRatio) {
		this.correctRatio = correctRatio;
	}

	public String getCorrectTimes() {
		return correctTimes;
	}

	public void setCorrectTimes(String correctTimes) {
		this.correctTimes = correctTimes;
	}

	public String getTotalTimes() {
		return totalTimes;
	}

	public void setTotalTimes(String totalTimes) {
		this.totalTimes = totalTimes;
	}

	public String getMcqID() {
		return mcqID;
	}

	public void setMcqID(String mcqID) {
		this.mcqID = mcqID;
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

	public String getCntOfOptionA() {
		return cntOfOptionA;
	}

	public void setCntOfOptionA(String cntOfOptionA) {
		this.cntOfOptionA = cntOfOptionA;
	}

	public String getCntOfOptionB() {
		return cntOfOptionB;
	}

	public void setCntOfOptionB(String cntOfOptionB) {
		this.cntOfOptionB = cntOfOptionB;
	}

	public String getCntOfOptionC() {
		return cntOfOptionC;
	}

	public void setCntOfOptionC(String cntOfOptionC) {
		this.cntOfOptionC = cntOfOptionC;
	}

	public String getCntOfOptionD() {
		return cntOfOptionD;
	}

	public void setCntOfOptionD(String cntOfOptionD) {
		this.cntOfOptionD = cntOfOptionD;
	}

	public String getMcqTitle() {
		return mcqTitle;
	}

	public void setMcqTitle(String mcqTitle) {
		this.mcqTitle = mcqTitle;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getCrtAnswer() {
		return crtAnswer;
	}

	public void setCrtAnswer(String crtAnswer) {
		this.crtAnswer = crtAnswer;
	}

}
