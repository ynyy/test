package com.orm;

public class TMessage{
	
	private Integer msgId;
	private String userIp;
	private Integer classId;
	private String msgContent;
	private String createTime;

	public TMessage(){
		super();
	}

	public TMessage(Integer msgId, String userIp, Integer classId, String msgContent, String createTime){
		super();
		this.msgId = msgId;
		this.userIp = userIp;
		this.classId = classId;
		this.msgContent = msgContent;
		this.createTime = createTime;
	}

	public Integer getMsgId(){
		return msgId;
	}

	public void setMsgId(Integer msgId){
		this.msgId = msgId;
	}

	public String getUserIp(){
		return userIp;
	}

	public void setUserIp(String userIp){
		this.userIp = userIp;
	}

	public Integer getClassId(){
		return classId;
	}

	public void setClassId(Integer classId){
		this.classId = classId;
	}

	public String getMsgContent(){
		return msgContent;
	}

	public void setMsgContent(String msgContent){
		this.msgContent = msgContent;
	}

	public String getCreateTime(){
		return createTime;
	}

	public void setCreateTime(String createTime){
		this.createTime = createTime;
	}

}
