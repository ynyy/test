package com.orm;

public class Tuser {
	private String userID;
    private String loginname;
	private String loginpsw;
	private String portrait;

	public String getPortrait() {
		return portrait;
	}

	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getLoginpsw() {
		return loginpsw;
	}

	public void setLoginpsw(String loginpsw) {
		this.loginpsw = loginpsw;
	}
	
}
