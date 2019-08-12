package com.action;

import java.io.IOException;
import java.net.InetAddress;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.DB;
import com.orm.Tanswer;
import com.orm.TMessage;
import com.orm.Tuser;
import com.util.JsonUtil;

public class MessageServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		String type=req.getParameter("type");
		if(type.endsWith("teacherForumDetail"))
		{
			 teacherForumDetail(req, res);
		}
		
		if(type.endsWith("messageJson"))
		{
			 messageJson(req, res);
		}
		
		
		if(type.endsWith("stuForumDetail"))
		{
			 stuForumDetail(req, res);
		}
		
		if(type.endsWith("stuSendMsg"))
		{
			 stuSendMsg(req, res);
		}
	}
	
	public void stuSendMsg(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		String classID=req.getParameter("classID");
		String msgContent = req.getParameter("msgContent");
		String sql = "insert into t_message(class_id, msg_content, msg_createtime, ip_addr) VALUES(?, ?, NOW(), ?)";
		DB mydb = new DB();
		try{
			String localIP = InetAddress.getLocalHost().getHostAddress(); // 获得本机IP
			mydb.doPstm(sql, new Object[]{classID, msgContent, localIP});
			mydb.closed();
		}catch(Exception e){
			e.printStackTrace();
		}
			req.setAttribute("classID", classID);
			req.getRequestDispatcher("/student/stuforum.jsp").forward(req, res);
	}
	
	public void teacherForumDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		
		String classID=req.getParameter("classID");
		
		if (user != null) {
			req.setAttribute("classID", classID);
			req.getRequestDispatcher("/page/forumdetail.jsp").forward(req, res);
		}else{
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	
	public void stuForumDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String classID=req.getParameter("classID");
		req.setAttribute("classID", classID);
		req.getRequestDispatcher("/student/stuforum.jsp").forward(req, res);
		
	}
	
	public void messageJson(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String classID=req.getParameter("classID");
		
		List messageList = new ArrayList();
		
		String sql = " select msg_id, msg_content, msg_createtime, ip_addr"
				+" from t_message where 1=1 and class_id=? order by msg_createtime desc ";
		Object[] params = {classID};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				TMessage message = new TMessage();
				message.setMsgId(Integer.parseInt(rs.getString("msg_id")));
				message.setMsgContent(rs.getString("msg_content"));
				message.setCreateTime(rs.getString("msg_createtime"));
				message.setUserIp(rs.getString("ip_addr"));
				
				System.out.println("*******Log for message json:*******\n" + "Message ID: " + rs.getString("msg_id") + ", Message Content:" + rs.getString("msg_content") + ", Create Time:" + rs.getString("msg_createtime"));
					 
				messageList.add(message);		
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.list2json(messageList));
	}

	
	
	// ----------------------------------------------------------------
	public void dispatch(String targetURI, HttpServletRequest request, HttpServletResponse response){
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(targetURI);
		try{
			dispatch.forward(request, response);
			return;
		}catch(ServletException e){
			e.printStackTrace();
		}catch(IOException e){

			e.printStackTrace();
		}
	}

	public void init(ServletConfig config) throws ServletException{
		super.init(config);
	}

	public void destroy(){}
}
