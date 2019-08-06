package com.service;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import com.dao.DB;
import com.orm.Tclass;
import com.orm.Tmcq;

public class liuService
{
	//随机生成6位ID
	public static int getRandomID()
	{
		    int max=999999;
	        int min=100000;
	        Random random = new Random();

	        int s = random.nextInt(max)%(max-min+1) + min;
	        return s;
	}
	
	//判断生成的6位classID是否和数据库中的classID重复， 重复则返回true，不重复返回false
	public static boolean judgeIDExist(int ID, String sql){
		boolean result = false;
		List classList = new ArrayList();
		Object[] params = {ID};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				result = true;
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		return result;
	}
	
	//向数据库中插入学生回答问题的ip地址、时间等记录
	public static void stuAdd(String ipAddr, String attemptID, String time) throws IOException {
		String sql = "insert into t_student(ip_addr, attempt_id, answer_createtime) values(?,?,?)";
		Object[] params = {ipAddr, attemptID, time };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();
	}
	
	
	public static boolean queryHasSubmitAnswer(String ip, String attemptID) throws IOException {
		boolean result = false;
		String sql = " select *	from t_student where 1=1 and ip_addr=? and attempt_id=? ";
		List studentList = new ArrayList();
		Object[] params = {ip,attemptID};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {  //有查询结果，说明该ip已经作答过该quiz
				result = true;
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		return result;  //result结果为true，说明已经作答；结果为false，说明未作答
	}
}
