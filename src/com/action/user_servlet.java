package com.action;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.DB;
import com.orm.Tuser;

public class user_servlet extends HttpServlet{
	//User services for lecturer end
	public void service(HttpServletRequest req,HttpServletResponse res)throws ServletException, IOException 
	{
        String type=req.getParameter("type");
		if(type.endsWith("teacherLogin"))
		{
			teacherLogin(req, res);
		}
		else if(type.endsWith("teacherLogout"))
		{
			teacherLogout(req, res);
		}
		else if(type.endsWith("teacherEdit"))
		{
			teacherEdit(req, res);
		}
		
	}
	
	public void teacherLogin(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException{
		String result="no";
		String loginName=req.getParameter("loginName");
		String loginPw=req.getParameter("loginPw");
		String sql="select * from t_lecturer where  loginname=? and loginpsw=?";
		Object[] params={loginName,loginPw};
		DB mydb=new DB();
		try
		{
			mydb.doPstm(sql, params);
			ResultSet rs=mydb.getRs();
			boolean mark=(rs==null||!rs.next()?false:true);
			if(mark==false)
			{
				result="no";
			}
			if(mark==true)
			{
				result="yes";
				Tuser user=new Tuser();
				user.setUserID(rs.getString("lecturer_id"));
				user.setLoginname(rs.getString("loginname"));
				user.setLoginpsw(rs.getString("loginpsw"));
				user.setPortrait(rs.getString("portraitpath"));
	            req.getSession().setAttribute("user", user);
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		mydb.closed();
		
		if(result.equalsIgnoreCase("yes")){
//		        req.setAttribute("message","Login success!");
//				req.setAttribute("path","module?type=mylecture");
//				String targetURL = "/common/success.jsp";
//				dispatch(targetURL, req, res);
				req.getRequestDispatcher("quiz?type=myquiz").forward(req, res);
			
		}else{
				req.setAttribute("message", "Wrong username or password!");
				req.setAttribute("path","/jplecture/page/login.jsp");
				String targetURL = "/common/success.jsp";
				dispatch(targetURL, req, res);
		}
	}
	
	public void teacherLogout(HttpServletRequest req,HttpServletResponse res)
	{
		req.getSession().setAttribute("user", null);
		String targetURL = "/page/login.jsp";
		dispatch(targetURL, req, res);		
	}
	
	public void teacherEdit(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		String result="no";
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		Tuser user=(Tuser)req.getSession().getAttribute("user");
		//String loginname= req.getParameter("loginname");
		String loginID=user.getUserID();
		String loginpw=req.getParameter("loginpw");
		String oldpw=req.getParameter("oldpw");
		String crpw=null;
		int loginIDn=Integer.parseInt(loginID);
		System.out.println("***Login ID is:"+loginIDn);
		String sql0="select * from t_lecturer where lecturer_id=?";
		Object[] params0={loginIDn};
		DB mydb0=new DB();
		try
		{
			mydb0.doPstm(sql0, params0);
			ResultSet rs=mydb0.getRs();
			while (rs.next()) {
			crpw=rs.getString("loginpsw");
			System.out.println("***old crt psw is:"+crpw);
			System.out.println("***old entered psw is:"+crpw);
			if(!crpw.equals(oldpw))
			{
				result="no";
			}
			if(crpw.equals(oldpw))
			{
				result="yes";
			}
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		mydb0.closed();
if(result.equalsIgnoreCase("yes")){		
		String sql=" update t_lecturer set loginpsw=? where lecturer_id=? ";
		Object[] params={loginpw,loginIDn};
		DB mydb=new DB();
		mydb.doPstm(sql, params);
		mydb.closed();
		user.setLoginpsw(loginpw);
		req.getSession().setAttribute("user", user);
		req.setAttribute("message", "Change password succeed.");
		req.setAttribute("path","/jplecture/page/myinfo.jsp");
		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
		}else
			{
			req.setAttribute("message", "Wrong password! Please enter the previous password again.");
			req.setAttribute("path","/jplecture/page/myinfo.jsp");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);
				}
		}

	public static String getClientIp(HttpServletRequest request){
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public void dispatch(String targetURI,HttpServletRequest request,HttpServletResponse response) 
	{
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(targetURI);
		try {
		    dispatch.forward(request, response);
		    return;
		} 
		catch (ServletException e) 
		{e.printStackTrace();} 
		catch (IOException e) 
		{e.printStackTrace();}
	}
	
	public void init(ServletConfig config) throws ServletException 
	{
		super.init(config);
	}
	
}
