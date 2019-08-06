package com.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.DB;
import com.orm.Tclass;
import com.orm.Tquiz;
import com.orm.Tfenxi;
import com.orm.Tmodule;
import com.orm.Tstu;
import com.orm.Tmcq;
import com.orm.Tuser;
import com.orm.TMessage;
import com.service.liuService;
import com.util.JsonUtil;
import com.action.user_servlet;

public class module_servlet extends HttpServlet {

	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String type = req.getParameter("type");
		
		if (type.endsWith("mylecture")) {
			mylecture(req, res);
		}
		
		if (type.endsWith("classAdd")) {
			classAdd(req, res);
		}
		
		if (type.endsWith("classDel")) {
			classDel(req, res);
		}
		
		if (type.endsWith("moduleJson")) {
			moduleJson(req, res);
		}
		
		if (type.endsWith("classJson")) {
			classJson(req, res);
		}
		
		if (type.endsWith("judgeClassIDExist")) {
			judgeClassIDExist(req, res);
		}
		if (type.endsWith("lectureEnable")) {
			lectureEnable(req, res);
		}
		
		if (type.endsWith("lectureDisable")) {
			lectureDisable(req, res);
		}
		
	}

	/*************以下为具体的函数*************/
	public void mylecture(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
	
		if (user != null) {
			String sql = " select aa.*,bb.module_name  " + " from t_class aa "
					+ " join t_module bb on bb.module_id=aa.module_id "
					+ " where 1=1  and aa.lecturer_id=?"
					+ "	order by aa.class_createtime desc" ;
			
			List classList = new ArrayList();
			Object[] params = { user.getUserID() };
			DB mydb = new DB();
			try {
				mydb.doPstm(sql, params);
				ResultSet rs = mydb.getRs();
				while (rs.next()) {
					Tclass classinfo = new Tclass();
					classinfo.setClassID(rs.getString("class_id"));
					classinfo.setClassName(rs.getString("class_name"));
					classinfo.setClassCreatetime(rs.getString("class_createtime"));
					classinfo.setModuleID(rs.getString("module_id"));
					classinfo.setModuleName(rs.getString("module_name"));
					classinfo.setClassURL(rs.getString("class_url"));
					classinfo.setComment(rs.getString("comment"));
					classinfo.setStatus(rs.getString("status"));
					classList.add(classinfo);
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb.closed();
			req.setAttribute("classList", classList);
			req.getRequestDispatcher("/page/mylecture.jsp").forward(req, res);
		}else{
			req.getRequestDispatcher("/page/login.jsp").forward(req, res);
		}
	}

	public void classAdd(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {
			
			String sql1 = " select * from t_class aa "     
					+ " where 1=1 and aa.class_id=? ";
			int classID = liuService.getRandomID();
			while(liuService.judgeIDExist(classID,sql1)==true){  //若classID已存在，则结果为true，重新生成ID
				classID = liuService.getRandomID();
			}
			
			String classname = req.getParameter("classname");
			String moduleID = req.getParameter("moduleID");
			String comment=req.getParameter("comment");
			String classURL = "class" + classID;
			String status="enabled";
			System.out.println("新生成Class的url是： " + classURL+"日期是："+comment);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			
			String sql2 = "insert into t_class(class_id,class_name,module_id,lecturer_id, class_createtime,class_url,comment,status) values(?,?,?,?,?,?,?,?)";
			Object[] params = { classID, classname, moduleID,
					user.getUserID(), df.format(new Date()), classURL,comment,status};
			DB mydb = new DB();
			mydb.doPstm(sql2, params);
			mydb.closed();

			req.setAttribute("message", "Create class success.");
			req.setAttribute("path", "module?type=mylecture");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}
	
	public void classDel(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String classID = req.getParameter("classID");
		
		if (user != null) {
			Object[] params = { classID };
			
			//删除class时先删除此class的所有message
			String sql1 = " delete " + " from t_message " 
					+ "where 1=1 and class_id=?";
			DB mydb1 = new DB();
			try {
				mydb1.doPstm(sql1, params);
			}catch (Exception e) {
			  e.printStackTrace();
			}
			mydb1.closed();
			
			//删除class时再将此class的所有quiz的classID设为空（取消与class的关联）
			String sql2 = " update " + " t_quiz " + "set class_id = null "
					+ "where 1=1 and class_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			}catch (Exception e) {
			  e.printStackTrace();
			}
			mydb2.closed();	
			
			//删除class时最后将class从t_class表中删除
			String sql3 = " delete " + " from t_class " 
					+ "where 1=1 and class_id=?";
			DB mydb3 = new DB();
			try {
				mydb3.doPstm(sql3, params);
			}catch (Exception e) {
			  e.printStackTrace();
			}
			mydb3.closed();	
			
			req.setAttribute("message", "Delete class record success.");
			req.setAttribute("path", "module?type=mylecture");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);
			
		}else{
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	public void lectureEnable(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		// String quizID = req.getParameter("quizID"); quizID在删除attempt时暂时无关
		String classID = req.getParameter("classID");

		if (user != null) {
			Object[] params = { classID };

			// 再更新t_quiz中该status
	//		String sql1 = " update " + " from t_quiz " + "where 1=1 and attempt_id=?";
			String sql2 ="update t_class set status='enabled' where class_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("message", "Enabled lecture success.");
			req.setAttribute("path", "module?type=mylecture");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	
	public void lectureDisable(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		// String quizID = req.getParameter("quizID"); quizID在删除attempt时暂时无关
		String classID = req.getParameter("classID");

		if (user != null) {
			Object[] params = { classID };

			// 再更新t_quiz中该status
	//		String sql1 = " update " + " from t_quiz " + "where 1=1 and attempt_id=?";
			String sql2 ="update t_class set status='disabled' where class_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("message", "Disabled lecture success.");
			req.setAttribute("path", "module?type=mylecture");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	
	public void moduleJson(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		String sql = " select * from t_module ";
		System.out.println("进入modulejson");
		List moduleList = new ArrayList();
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tmodule module = new Tmodule();
				module.setModuleID(rs.getString("module_id"));
				module.setModulename(rs.getString("module_name"));
				moduleList.add(module);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.list2json(moduleList));
	}
	
	public void classJson(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		System.out.println("进入classjson");
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		Object[] params = { user.getUserID() };
		String sql = " select * from t_class where 1=1 and t_class.lecturer_id=? ";
		List classList = new ArrayList();
		
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tclass classinfo = new Tclass();
				classinfo.setClassID(rs.getString("class_id"));
				classinfo.setClassName(rs.getString("class_name"));
				classinfo.setClassCreatetime(rs.getString("class_createtime"));
				classinfo.setModuleID(rs.getString("module_id"));
				classinfo.setClassURL(rs.getString("class_url"));
				classinfo.setComment(rs.getString("comment"));
				classinfo.setStatus(rs.getString("status"));
				classList.add(classinfo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.list2json(classList));}
		else{req.getRequestDispatcher("page/login.jsp").forward(req, res);}
	}
	
	/*判断学生输入的class ID是否存在*/
	public boolean judgeClassIDExist(HttpServletRequest req, HttpServletResponse res) throws IOException {
//		req.setCharacterEncoding("utf-8");
//		res.setCharacterEncoding("utf-8");
//		Boolean result = false;
//		String classID = req.getParameter("classID");
//		String sql = " select * from t_class aa " 
//				+ " where 1=1 and aa.class_id=? ";
//		
//		if(liuService.judgeIDExist(Integer.parseInt(classID),sql)==true){
//			res.getWriter().println("success");
//			result = true;
//		}else{
//			res.getWriter().println("Class doesn't exist.");
//		}
//		return result;	
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		Boolean result = false;
		int judge1=1;//判断是否存在这个attempt，初始值为1，不存在
		int judge2=1;//判断这个attempt是否enabled，初始值为1，disabled
		String classID = req.getParameter("classID"); // 学生输入的ID其实是attempt ID
		String sql1 = " select * from t_class aa where 1=1 and aa.class_id=?";
		String status=null;
		String enabled="enabled";
		if (liuService.judgeIDExist(Integer.parseInt(classID), sql1) == true) {
		//	res.getWriter().println("success");
		//	result = true;
			judge1=0;//如果找到同一class号，则存在该class，judge1设为0；
		} else {
			res.getWriter().println("class doesn't exist.");
			result=false;
			return result;
		}
		
		String sql2=" select status from t_class aa " + " where 1=1 and aa.class_id=? ";
		Object[] params = { classID };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql2, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
	
				 status=rs.getString("status");
			
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		
		if(judge1==0&&status.equals(enabled))
		{
			res.getWriter().println("success");
				result = true;
				judge2=0;//如果状态为enabled，则该attempt可用，judge1设为0；
		}else {
			res.getWriter().println("Lecture is disabled.");
			result=false;	
		}
			
		
		return result;
		
	}
	

	public void dispatch(String targetURI, HttpServletRequest request,
			HttpServletResponse response) {
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(
				targetURI);
		try {
			dispatch.forward(request, response);
			return;
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {
	}
}
