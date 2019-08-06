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
import com.orm.Tanswer;
import com.orm.Tmodule;
import com.orm.Tstu;
import com.orm.Tmcq;
import com.orm.Tuser;
import com.orm.TMessage;
import com.service.liuService;
import com.util.JsonUtil;
import com.action.user_servlet;

public class quiz_servlet extends HttpServlet {

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String type = req.getParameter("type");

		// 进入教师端quiz功能函数
		if (type.endsWith("myquiz")) {
			myquiz(req, res);
		}
		if (type.endsWith("mcqOfClassJson")) {
			mcqOfClassJson(req, res);
		}
		if (type.endsWith("quizAdd")) {
			quizAdd(req, res);
		}

		if (type.endsWith("attemptDel")) {
			attemptDel(req, res);
		}
		if (type.endsWith("attemptEnable")) {
			attemptEnable(req, res);
		}
		if (type.endsWith("attemptDisable")) {
			attemptDisable(req, res);
		}
		if(type.endsWith("attemptRedo")) {
			attemptRedo(req , res);
		}

		if (type.endsWith("enterMcqBank")) {
			enterMcqBank(req, res);
		}
		if (type.endsWith("teacherQuizDetail")) {
			teacherQuizDetail(req, res);
		}

		if (type.endsWith("mcqResultJson")) {
			mcqResultJson(req, res);
		}

		if (type.endsWith("enterAddMcq")) {
			enterAddMcq(req, res);
		}

		if (type.endsWith("mcqAdd")) {
			mcqAdd(req, res);
		}
		if (type.endsWith("mcqAddFromReuse")) {
			mcqAddFromReuse(req, res);
		}

		if (type.endsWith("mcqDelFromQuiz")) {
			mcqDelFromQuiz(req, res);
		}

		if (type.endsWith("mcqReuse")) {
			mcqReuse(req, res);
		}
		if (type.endsWith("reuseEditing")) {
			reuseEditing(req, res);
		}
		if (type.endsWith("mcqEdit")) {
			mcqEdit(req, res);
		}
		if (type.endsWith("answerAdd")) {
			answerAdd(req, res);
		}
		if (type.endsWith("mcqUpdate")) {
			mcqUpdate(req, res);
		}
		if (type.endsWith("attemptEdit")) {
			attemptEdit(req, res);
		}
		if (type.endsWith("attemptUpdate")) {
			attemptUpdate(req, res);
		}

		// 进入学生端quiz功能函数
		if (type.endsWith("judgeQuizIDExist")) {
			judgeQuizIDExist(req, res);
		}

		if (type.endsWith("studentQuizDetail")) {
			studentQuizDetail(req, res);
		}

		if (type.endsWith("answerAdd")) {
			answerAdd(req, res);
		}
	}
	
	// *************教师端quiz功能函数*************
	public void myquiz(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {
			String sql = " select * from t_quiz aa " + " where 1=1  and aa.lecturer_id=?"
					+ "	order by aa.attempt_createtime desc, aa.quiz_id asc";

			List quizList = new ArrayList();
			Object[] params = { user.getUserID() };
			DB mydb = new DB();
			try {
				mydb.doPstm(sql, params);
				ResultSet rs = mydb.getRs();
				while (rs.next()) {
					Tquiz quizinfo = new Tquiz();
					quizinfo.setQuizID(rs.getString("quiz_id"));
					quizinfo.setQuizName(rs.getString("quiz_name"));
					quizinfo.setAttemptID(rs.getString("attempt_id"));
					quizinfo.setAttemptComment(rs.getString("attempt_comment"));
					quizinfo.setAttemptCreatetime(rs.getString("attempt_createtime"));
					quizinfo.setAttemptURL(rs.getString("attempt_url"));
					;
					quizinfo.setClassID(rs.getString("class_id"));
					quizinfo.setStatus(rs.getString("status"));
					quizList.add(quizinfo);
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb.closed();
			req.setAttribute("quizList", quizList);
			req.getRequestDispatcher("/page/myquiz.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("/page/login.jsp").forward(req, res);
		}
	}

	public void quizAdd(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {

			String sql1 = " select * from t_quiz aa " + " where 1=1 and aa.quiz_id=? ";

			String sql2 = " select * from t_quiz aa " + " where 1=1 and aa.attempt_id=? ";
			
		//	String sql3 = " select class_id from t_class aa where 1=1 and aa.class_name=? ";

			// 随机生成quizID和attemptID
			int quizID = liuService.getRandomID();
			int attemptID = liuService.getRandomID();
			while (liuService.judgeIDExist(quizID, sql1) == true) {
				quizID = liuService.getRandomID();
			}
			while (liuService.judgeIDExist(attemptID, sql2) == true) {
				attemptID = liuService.getRandomID();
			}

			String quizName = req.getParameter("quizname");
			//String classID = req.getParameter("classID");
			
			String className=req.getParameter("classname");
			System.out.println("所选从属class为"+className);
			String moduleName=req.getParameter("moduleID");
			System.out.println("所选从属module为"+moduleName);
			String attemptComment = req.getParameter("comment");
			String attemptURL = "attempt" + attemptID;
			String status = "enabled";
			System.out.println("新生成attempt的url是： " + attemptURL);
int classID=Integer.parseInt(className);

System.out.println("要加入表的classID是："+classID);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式

			
			
			String sql = "insert into t_quiz(quiz_id, attempt_id, quiz_name, class_id, lecturer_id, attempt_createtime, attempt_comment, attempt_url,status,module_id) values(?,?,?,?,?,?,?,?,?,?)";
			Object[] params = { quizID, attemptID, quizName, classID, user.getUserID(), df.format(new Date()),
					attemptComment, attemptURL,status,moduleName };

			DB mydb = new DB();
			mydb.doPstm(sql, params);
			mydb.closed();

			req.setAttribute("message", "Create quiz success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}

	public void attemptDel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		// String quizID = req.getParameter("quizID"); quizID在删除attempt时暂时无关
		String attemptID = req.getParameter("attemptID");

		if (user != null) {
			Object[] params = { attemptID };

			// 删除attempt时先删除t_answer中该条attempt的记录
			String sql1 = " delete " + " from t_answer " + "where 1=1 and attempt_id=?";
			DB mydb1 = new DB();
			try {
				mydb1.doPstm(sql1, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb1.closed();

			// 再删除t_quiz中该attempt的记录
			String sql2 = " delete " + " from t_quiz " + "where 1=1 and attempt_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("message", "Delete quiz attempt record success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	
	public void attemptEnable(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		// String quizID = req.getParameter("quizID"); quizID在删除attempt时暂时无关
		String attemptID = req.getParameter("attemptID");

		if (user != null) {
			Object[] params = { attemptID };

			// 再更新t_quiz中该status
	//		String sql1 = " update " + " from t_quiz " + "where 1=1 and attempt_id=?";
			String sql2 ="update t_quiz set status='enabled' where attempt_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("message", "Enabled quiz success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}

	public void attemptDisable(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		// String quizID = req.getParameter("quizID"); quizID在删除attempt时暂时无关
		String attemptID = req.getParameter("attemptID");

		if (user != null) {
			Object[] params = { attemptID };

			// 再更新t_quiz中该status
	//		String sql1 = " update " + " from t_quiz " + "where 1=1 and attempt_id=?";
			String sql2 ="update t_quiz set status='disabled' where attempt_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("message", "Disabled quiz success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}
	public void attemptEdit(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		// 查数据库 放到 前台
		// TODO
		String sql1 = "SELECT *  FROM t_quiz WHERE attempt_id=? ";
		Object[] params1 = { attemptID };
		DB mydb1 = new DB();

		String quiz_name = null;
		String class_name = null;
		String module_name = null;

		String class_id = null;
		String module_id = null;
		String attempt_comment = null;
		try {
			mydb1.doPstm(sql1, params1);
			ResultSet rs1 = mydb1.getRs();


			while (rs1.next()) {
				quiz_name = rs1.getString("quiz_name");
				class_id = rs1.getString("class_id");
				module_id = rs1.getString("module_id");
				attempt_comment = rs1.getString("attempt_comment");
			}
			rs1.close();

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb1.closed();
		String sql2 = "SELECT *  FROM t_class WHERE class_id=? ";
		int intclass_id=Integer.parseInt(class_id);
		Object[] params2 = { intclass_id };
		DB mydb2 = new DB();
		try {
			mydb2.doPstm(sql2, params2);
			ResultSet rs2 = mydb2.getRs();


			while (rs2.next()) {
				class_name = rs2.getString("class_name");
			}
			rs2.close();

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb2.closed();
		String sql3 = "SELECT *  FROM t_module WHERE module_id=? ";
		Object[] params3 = { module_id };
		DB mydb3 = new DB();
		try {
			mydb3.doPstm(sql3, params3);
			ResultSet rs3 = mydb3.getRs();


			while (rs3.next()) {
				module_name = rs3.getString("module_name");
			}
			rs3.close();

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb3.closed();
		
		

		if (user != null) {
			// String classID=req.getParameter("classID");
			req.setAttribute("quiz_name", quiz_name);
			req.setAttribute("attempt_comment", attempt_comment);
			req.setAttribute("class_name", class_name);
			req.setAttribute("module_name", module_name);
			req.setAttribute("attemptID", attemptID);

			System.out.println("***这是测试是否进入quizEdit：quizID是 " + quizID + "attemptID是 " + attemptID + "classname是 " + class_name+ "modulename是 " + module_name);
			req.getRequestDispatcher("/page/editQuiz.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
		}
	
	
	public void attemptUpdate(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		if (user != null) {

			String quizName = req.getParameter("quizname");
			//String classID = req.getParameter("classID");
			System.out.println("quiz名为"+quizName);
			String className=req.getParameter("classname");
			System.out.println("所选从属class为"+className);
			String moduleName=req.getParameter("moduleID");
			System.out.println("所选从属module为"+moduleName);
			String attemptComment = req.getParameter("comment");
			System.out.println("时间为"+attemptComment);

			String attemptID = req.getParameter("attemptID");

			System.out.println("该attemptId:"+attemptID);

int classID=Integer.parseInt(className);

String sql = "update t_quiz set quiz_name=?,class_id=?,attempt_comment=?,module_id=? where attempt_id=?";
			Object[] params = { quizName, classID, attemptComment,moduleName,attemptID };

			DB mydb = new DB();
			mydb.doPstm(sql, params);
			mydb.closed();

			req.setAttribute("message", "Edit quiz success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);

	}}
	
	public void attemptRedo(HttpServletRequest req , HttpServletResponse res) 
			throws ServletException, IOException{
		
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		
	
		if (user != null) {
			String sql1 = " select * from t_quiz aa " + " where 1=1 and aa.quiz_id=? ";
			String sql2 = " select * from t_quiz aa " + " where 1=1 and aa.attempt_id=? ";
	
		//	String sql3 = " select class_id from t_class aa where 1=1 and aa.class_name=? ";

			// 随机生成quizID和attemptID
			int quizID = liuService.getRandomID();
			int attemptID = liuService.getRandomID();
			while (liuService.judgeIDExist(quizID, sql1) == true) {
				quizID = liuService.getRandomID();
			}
			while (liuService.judgeIDExist(attemptID, sql2) == true) {
				attemptID = liuService.getRandomID();
			}

			String sql3 = "selet * from t_quiz where quiz_id = ? and attempt_id = ? ";
			String quizID1 = req.getParameter("quizID");
			String attemptID1 = req.getParameter("attemptID");
			System.out.print(quizID1);
			Object[] params1 = {quizID1 , attemptID1};
			DB db1 = new DB();	
			String quizName = null;
			//String classID = req.getParameter("classID");
			String className = null;
			String moduleName = null;
			String attemptComment = null;
			String attemptURL = "attempt" + attemptID;
			String status = "enable";
			int classID = 0;
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			try {
				db1.doPstm(sql3, params1);
				ResultSet rss = db1.getRs();

				while (rss.next()) {
					quizName = rss.getString("quiz_name");
					className = rss.getString("class_id");
					moduleName = rss.getString("module_id");
					attemptComment = rss.getString("attempt_comment");
					classID=Integer.parseInt(className);
				}
				rss.close();			
			} catch (Exception e) {
				e.printStackTrace();
			}

			String sql = "insert into t_quiz(quiz_id, attempt_id, quiz_name, class_id, lecturer_id, attempt_createtime, attempt_comment, attempt_url,status,module_id) values(?,?,?,?,?,?,?,?,?,?)";
			Object[] params = { quizID, attemptID, quizName, classID, user.getUserID(), df.format(new Date()),
					attemptComment, attemptURL,status,moduleName };

			DB mydb = new DB();
			mydb.doPstm(sql, params);
			mydb.closed();

			req.setAttribute("message", "Create quiz success.");
			req.setAttribute("path", "quiz?type=myquiz");
			String targetURL = "/common/success.jsp";
			dispatch(targetURL, req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}
	
	public void teacherQuizDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String classID = req.getParameter("classID");// 用于mcqbank
		if (user != null) {
			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("classID", classID);
			req.getRequestDispatcher("/page/quizdetail.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}

	public void mcqResultJson(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");

		System.out.println("***这是测试是否进入mcqResultJson：quizID是 " + quizID + "attemptID是 " + attemptID);

		List mcqResultList = new ArrayList();

		String sql = " select bb.mcq_id, bb.mcq_title, bb.mcq_optionA, bb.mcq_optionB, bb.mcq_optionC, bb.mcq_optionD, bb.mcq_answer, bb.url,"
				+ " aa.attempt_id, aa.optionA_count, aa.optionB_count, aa.optionC_count, aa.optionD_count "
				+ " from t_answer aa join t_mcq bb join t_quizhasmcq cc on aa.mcq_id=bb.mcq_id and bb.mcq_id=cc.mcq_id where 1=1 and aa.quiz_id=? and aa.attempt_id=? order by cc.relation_id";
		Object[] params = { quizID, attemptID };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tanswer mcqResult = new Tanswer();
				mcqResult.setMcqID(rs.getString("mcq_id"));

				// mcqResult.setQuizID(rs.getString("quiz_id"));
				mcqResult.setAttemptID(rs.getString("attempt_id"));
				mcqResult.setMcqTitle(rs.getString("mcq_title"));
				mcqResult.setOptionA(rs.getString("mcq_optionA"));
				mcqResult.setOptionB(rs.getString("mcq_optionB"));
				mcqResult.setOptionC(rs.getString("mcq_optionC"));
				mcqResult.setOptionD(rs.getString("mcq_optionD"));
				mcqResult.setCrtAnswer(rs.getString("mcq_answer"));
				mcqResult.setCntOfOptionA(rs.getString("optionA_count"));
				mcqResult.setCntOfOptionB(rs.getString("optionB_count"));
				mcqResult.setCntOfOptionC(rs.getString("optionC_count"));
				mcqResult.setCntOfOptionD(rs.getString("optionD_count"));
				mcqResult.setUrl(rs.getString("url"));
				String correctTimes = rs.getString("option" + rs.getString("mcq_answer") + "_count");
				mcqResult.setCorrectTimes(correctTimes);
				String totalTimes = Integer.toString((Integer.parseInt(rs.getString("optionA_count"))
						+ Integer.parseInt(rs.getString("optionB_count"))
						+ Integer.parseInt(rs.getString("optionC_count"))
						+ Integer.parseInt(rs.getString("optionD_count"))));
				mcqResult.setTotalTimes(totalTimes);

				try {
					java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
					if (Integer.parseInt(totalTimes) > 0) {
						Double crtRatio = 100 * Double.parseDouble(correctTimes) / Double.parseDouble(totalTimes);
						String correctRatio = String.valueOf(df.format(crtRatio)) + "%";
						mcqResult.setCorrectRatio(correctRatio);
					} else {
						mcqResult.setCorrectRatio("No one has answered.");
					}
				} catch (Exception e) {
					mcqResult.setCorrectRatio("No one has answered.");
				}

				System.out.println("*******Log for mcq result:*******\n" + "MCQ ID: " + rs.getString("mcq_id")
						+ "选项A数目:" + rs.getString("optionA_count") + ", 选项B数目:" + rs.getString("optionB_count")
						+ ", 选项C数目:" + rs.getString("optionC_count") + ", 选项D数目:" + rs.getString("optionD_count")
						+ ", 正确选项:" + rs.getString("mcq_answer") + ", 正答数:" + correctTimes + "正答率:"
						+ mcqResult.getCorrectRatio());

				mcqResultList.add(mcqResult);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.list2json(mcqResultList));
	}

	public void mcqOfClassJson(HttpServletRequest req, HttpServletResponse res)// 用于question
																				// bank
			throws ServletException, IOException {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String classID = req.getParameter("classID");

		System.out.println(
				"***这是测试是否进入mcqofClassJson：quizID是 " + quizID + "attemptID是 " + attemptID + "classID是 " + classID);

		List mcqResultList = new ArrayList();

		Tuser user1 = (Tuser) req.getSession().getAttribute("user");

		if (user1 == null) {

			req.getRequestDispatcher("page/login.jsp").forward(req, res);
			return;
		}
		String sql = "select  bb.mcq_id, cc.mcq_title, cc.mcq_optionA, cc.mcq_optionB, cc.mcq_optionC,cc.mcq_optionD, cc.mcq_answer, cc.url, aa.attempt_id, dd.optionA_count, dd.optionB_count, dd.optionC_count, dd.optionD_count  from t_quiz aa , t_quizhasmcq bb,t_mcq cc,t_answer dd where aa.quiz_id=bb.quiz_id and bb.mcq_id=cc.mcq_id and dd.quiz_id = aa.quiz_id and cc.lecturer_id=? GROUP BY cc.mcq_id ";
		System.out.println("================" + sql);
		System.out.println("=============" + classID);
		Object[] params = { user1.getUserID() };
		DB mydb = new DB();
		try {

			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tanswer mcqResult = new Tanswer();
				mcqResult.setMcqID(rs.getString("mcq_id"));

				// mcqResult.setQuizID(rs.getString("quiz_id"));
				mcqResult.setAttemptID(rs.getString("attempt_id"));
				mcqResult.setMcqTitle(rs.getString("mcq_title"));
				mcqResult.setOptionA(rs.getString("mcq_optionA"));
				mcqResult.setOptionB(rs.getString("mcq_optionB"));
				mcqResult.setOptionC(rs.getString("mcq_optionC"));
				mcqResult.setOptionD(rs.getString("mcq_optionD"));
				mcqResult.setCrtAnswer(rs.getString("mcq_answer"));
				mcqResult.setCntOfOptionA(rs.getString("optionA_count"));
				mcqResult.setCntOfOptionB(rs.getString("optionB_count"));
				mcqResult.setCntOfOptionC(rs.getString("optionC_count"));
				mcqResult.setCntOfOptionD(rs.getString("optionD_count"));
				mcqResult.setUrl(rs.getString("url"));
				String correctTimes = rs.getString("option" + rs.getString("mcq_answer") + "_count");
				mcqResult.setCorrectTimes(correctTimes);
				String totalTimes = Integer.toString((Integer.parseInt(rs.getString("optionA_count"))
						+ Integer.parseInt(rs.getString("optionB_count"))
						+ Integer.parseInt(rs.getString("optionC_count"))
						+ Integer.parseInt(rs.getString("optionD_count"))));
				mcqResult.setTotalTimes(totalTimes);

				try {
					java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
					if (Integer.parseInt(totalTimes) > 0) {
						Double crtRatio = 100 * Double.parseDouble(correctTimes) / Double.parseDouble(totalTimes);
						String correctRatio = String.valueOf(df.format(crtRatio)) + "%";
						mcqResult.setCorrectRatio(correctRatio);
					} else {
						mcqResult.setCorrectRatio("No one has answered.");
					}
				} catch (Exception e) {
					mcqResult.setCorrectRatio("No one has answered.");
				}

				System.out.println("*******同一le下的所有mcq:*******\n" + "MCQ ID: " + rs.getString("mcq_id") + "选项A数目:"
						+ rs.getString("optionA_count") + ", 选项B数目:" + rs.getString("optionB_count") + ", 选项C数目:"
						+ rs.getString("optionC_count") + ", 选项D数目:" + rs.getString("optionD_count") + ", 正确选项:"
						+ rs.getString("mcq_answer") + ", 正答数:" + correctTimes + "正答率:" + mcqResult.getCorrectRatio());

				mcqResultList.add(mcqResult);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.list2json(mcqResultList));
	}

	public void enterAddMcq(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {
			String quizID = req.getParameter("quizID");
			String attemptID = req.getParameter("attemptID");
			String classID = req.getParameter("classID");
			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("classID", classID);
			System.out.println(
					"***这是测试是否进入enterAddMCQ：quizID是 " + quizID + "attemptID是 " + attemptID + "classID是 " + classID);
			req.getRequestDispatcher("/page/addquestion.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}

	// bank
	public void enterMcqBank(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");

		if (user != null) {
			String quizID = req.getParameter("quizID");
			String attemptID = req.getParameter("attemptID");
			String classID = req.getParameter("classID");
			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("classID", classID);

			System.out.println(
					"***这是测试是否进入enterMcqBank：quizID是 " + quizID + "attemptID是 " + attemptID + "classID是 " + classID);

			req.getRequestDispatcher("/page/mcqBank.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}

	public void mcqAdd(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
		req.setCharacterEncoding("UTF-8");
		//String prefix="C:/temp";
		String url=null;
		url = (String) req.getSession().getServletContext().getAttribute("url");
	//	url=url.replace("/", "\");
		System.out.println("上传路径地址--->" + url);
		// url
		if (url==null)
		{
			System.out.println("进入空白判断");
			url="/temp/20181004/20181004.jpg";
		}
		if (user != null) {
			res.setContentType("text/plain");
			req.setCharacterEncoding("utf-8");
			res.setCharacterEncoding("utf-8");

			String sql = " select * from t_mcq " + " where 1=1 and mcq_id=? ";
			int mcqID = liuService.getRandomID();
			while (liuService.judgeIDExist(mcqID, sql) == true) { // 若classID已存在，则结果为true，重新生成ID
				mcqID = liuService.getRandomID();
			}

			String quizID = req.getParameter("quizID");
			String attemptID = req.getParameter("attemptID");
			String classID=req.getParameter("classID");
			System.out.println("进入mcqadd classID:"+classID+"ATT:"+attemptID+"quiz:"+quizID);
			String mcqTitle = req.getParameter("mcqTitle");
			// String mcqTitle = req.getParameter("mcqTitle");
			String optionA = req.getParameter("optionA");
			String optionB = req.getParameter("optionB");
			String optionC = req.getParameter("optionC");
			String optionD = req.getParameter("optionD");
//			String mcqTitle = java.net.URLDecoder.decode(req.getParameter("mcqTitle"), "utf-8");
			// String mcqTitle = req.getParameter("mcqTitle");
//			String optionA = java.net.URLDecoder.decode(req.getParameter("optionA"), "utf-8");
//			String optionB = java.net.URLDecoder.decode(req.getParameter("optionB"), "utf-8");
//			String optionC = java.net.URLDecoder.decode(req.getParameter("optionC"), "utf-8");
//			String optionD = java.net.URLDecoder.decode(req.getParameter("optionD"), "utf-8");
			String mcqAnswer = req.getParameter("mcqAnswer");
			// System.out.println("*****测试接收到的新增mcq题干的长度是:"+java.net.URLDecoder.decode(mcqTitle,
			// "utf-8").length());

			String sql1 = "insert into t_mcq(mcq_id,mcq_title,mcq_optionA,mcq_optionB,mcq_optionC,mcq_optionD,mcq_answer,lecturer_id,url) values(?,?,?,?,?,?,?,?,?)";
			// Object[] params1={mcqID,mcqTitle,optionA,
			// "utf-8"),java.net.URLDecoder.decode(optionB,
			// "utf-8"),java.net.URLDecoder.decode(optionC,
			// "utf-8"),java.net.URLDecoder.decode(optionD,
			// "utf-8"),java.net.URLDecoder.decode(mcqAnswer,
			// "utf-8"),user.getUserID(),url};
			Object[] params1 = { mcqID, mcqTitle, optionA, optionB, optionC, optionD, mcqAnswer, user.getUserID(),
					url };

			DB mydb1 = new DB();
			mydb1.doPstm(sql1, params1);
			mydb1.closed();

			String sql2 = "insert into t_quizhasmcq(quiz_id, mcq_id) values(?,?)";
			Object[] params2 = { quizID, mcqID };
			DB mydb2 = new DB();
			mydb2.doPstm(sql2, params2);
			mydb2.closed();

			String sql3 = "insert into t_answer(mcq_id,quiz_id,attempt_id,optionA_count,optionB_count,optionC_count,optionD_count) values(?,?,?,?,?,?,?)";
			Object[] params3 = { mcqID, quizID, attemptID, 0, 0, 0, 0 };
			DB mydb3 = new DB();
			mydb3.doPstm(sql3, params3);
			mydb3.closed();

			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("classID", classID);
			req.setAttribute("message", "Create mcq success22.");
			req.setAttribute("path", "quiz?type=teacherQuizDetail");
			teacherQuizDetail(req, res);
//			req.setAttribute("user", user);
			//String targetURL = "/common/success.jsp";
			//dispatch(targetURL, req, res);
			
			//req.getRequestDispatcher("/page/myquiz.jsp").forward(req, res);
			//System.out.println("mcqadd有没有跳转");
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}
	
	public void mcqAddFromReuse(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
	//	String prefix="file:///Users/slythel/Desktop";
	//	String url = prefix.concat((String) req.getSession().getServletContext().getAttribute("url"));
		String oldurl = null;
//		System.out.println("上传路径地址--->" + url);
		// url
		

		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String oldmcqID = req.getParameter("mcqID");

		
		
		System.out.println("成功进入");
		
		
		
		if (user != null) {
			res.setContentType("text/plain");
			req.setCharacterEncoding("utf-8");
			res.setCharacterEncoding("utf-8");

			String sql="select url from t_mcq aa where aa.mcq_id=?";//提取之前mcq的图片url
			Object[] params = {oldmcqID};
			DB mydb = new DB();
			try {
				mydb.doPstm(sql, params);
				ResultSet rs = mydb.getRs();
				while (rs.next()) {
					oldurl=rs.getString("url");
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb.closed();
			
			
			
			String sql0 = " select * from t_mcq " + " where 1=1 and mcq_id=? ";
			int mcqID = liuService.getRandomID();
			while (liuService.judgeIDExist(mcqID, sql0) == true) { // 若classID已存在，则结果为true，重新生成ID
				mcqID = liuService.getRandomID();
			}

			String mcqTitle = java.net.URLDecoder.decode(req.getParameter("mcqTitle"), "utf-8");
			// String mcqTitle = req.getParameter("mcqTitle");
			String optionA = java.net.URLDecoder.decode(req.getParameter("optionA"), "utf-8");
			String optionB = java.net.URLDecoder.decode(req.getParameter("optionB"), "utf-8");
			String optionC = java.net.URLDecoder.decode(req.getParameter("optionC"), "utf-8");
			String optionD = java.net.URLDecoder.decode(req.getParameter("optionD"), "utf-8");
			String mcqAnswer = req.getParameter("mcqAnswer");
			// System.out.println("*****测试接收到的新增mcq题干的长度是:"+java.net.URLDecoder.decode(mcqTitle,
			// "utf-8").length());

			String sql1 = "insert into t_mcq(mcq_id,mcq_title,mcq_optionA,mcq_optionB,mcq_optionC,mcq_optionD,mcq_answer,lecturer_id,url) values(?,?,?,?,?,?,?,?,?)";
			// Object[] params1={mcqID,mcqTitle,optionA,
			// "utf-8"),java.net.URLDecoder.decode(optionB,
			// "utf-8"),java.net.URLDecoder.decode(optionC,
			// "utf-8"),java.net.URLDecoder.decode(optionD,
			// "utf-8"),java.net.URLDecoder.decode(mcqAnswer,
			// "utf-8"),user.getUserID(),url};
			Object[] params1 = { mcqID, mcqTitle, optionA, optionB, optionC, optionD, mcqAnswer, user.getUserID(),
					oldurl };

			DB mydb1 = new DB();
			mydb1.doPstm(sql1, params1);
			mydb1.closed();

			String sql2 = "insert into t_quizhasmcq(quiz_id, mcq_id) values(?,?)";
			Object[] params2 = { quizID, mcqID };
			DB mydb2 = new DB();
			mydb2.doPstm(sql2, params2);
			mydb2.closed();

			String sql3 = "insert into t_answer(mcq_id,quiz_id,attempt_id,optionA_count,optionB_count,optionC_count,optionD_count) values(?,?,?,?,?,?,?)";
			Object[] params3 = { mcqID, quizID, attemptID, 0, 0, 0, 0 };
			DB mydb3 = new DB();
			mydb3.doPstm(sql3, params3);
			mydb3.closed();

			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}

	public void mcqUpdate(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Tuser user = (Tuser) req.getSession().getAttribute("user");
	//	String prefix="file:///Users/slythel/Desktop";
	//	String url = prefix.concat((String) req.getSession().getServletContext().getAttribute("url"));
		String oldurl = null;
//		System.out.println("上传路径地址--->" + url);
		// url
		

		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String oldmcqID = req.getParameter("mcqID");

		
		
		System.out.println("成功进入");
		
		
		
		if (user != null) {
			res.setContentType("text/plain");
			req.setCharacterEncoding("utf-8");
			res.setCharacterEncoding("utf-8");

			String sql="select url from t_mcq aa where aa.mcq_id=?";//提取之前mcq的图片url
			Object[] params = {oldmcqID};
			DB mydb = new DB();
			try {
				mydb.doPstm(sql, params);
				ResultSet rs = mydb.getRs();
				while (rs.next()) {
					oldurl=rs.getString("url");
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb.closed();
			
			
			

			String mcqTitle = java.net.URLDecoder.decode(req.getParameter("mcqTitle"), "utf-8");
			// String mcqTitle = req.getParameter("mcqTitle");
			String optionA = java.net.URLDecoder.decode(req.getParameter("optionA"), "utf-8");
			String optionB = java.net.URLDecoder.decode(req.getParameter("optionB"), "utf-8");
			String optionC = java.net.URLDecoder.decode(req.getParameter("optionC"), "utf-8");
			String optionD = java.net.URLDecoder.decode(req.getParameter("optionD"), "utf-8");
			String mcqAnswer = req.getParameter("mcqAnswer");
			// System.out.println("*****测试接收到的新增mcq题干的长度是:"+java.net.URLDecoder.decode(mcqTitle,
			// "utf-8").length());

			String sql1 = "update t_mcq set mcq_title=?,mcq_optionA=?,mcq_optionB=?,mcq_optionC=?,mcq_optionD=?,mcq_answer=?,lecturer_id=?,url=? where mcq_id=?";
			// Object[] params1={mcqID,mcqTitle,optionA,
			// "utf-8"),java.net.URLDecoder.decode(optionB,
			// "utf-8"),java.net.URLDecoder.decode(optionC,
			// "utf-8"),java.net.URLDecoder.decode(optionD,
			// "utf-8"),java.net.URLDecoder.decode(mcqAnswer,
			// "utf-8"),user.getUserID(),url};
			Object[] params1 = { mcqTitle, optionA, optionB, optionC, optionD, mcqAnswer, user.getUserID(),
					oldurl, oldmcqID };

			DB mydb1 = new DB();
			mydb1.doPstm(sql1, params1);
			mydb1.closed();

			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}

	
	public void mcqDelFromQuiz(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String mcqID = req.getParameter("mcqID");

		if (user != null) {

			Object[] params = { mcqID, quizID };

			// 删除quiz中的mcq时先删除t_answer中此mcq在此quiz中的记录(每个attempt中的对应mcq都会删除)
			String sql1 = " delete " + " from t_answer " + "where 1=1 and mcq_id=? and quiz_id=?";
			DB mydb1 = new DB();
			try {
				mydb1.doPstm(sql1, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb1.closed();

			// 删除quiz中的mcq时再将t_quizhasmcq中该quiz对应该mcq的记录删掉
			String sql2 = " delete " + " from t_quizhasmcq " + "where 1=1 and mcq_id=? and quiz_id=?";
			DB mydb2 = new DB();
			try {
				mydb2.doPstm(sql2, params);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb2.closed();

			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			teacherQuizDetail(req, res);

		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}
	}

	public void mcqReuse(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String mcqID = req.getParameter("mcqID");

		// 查数据库 放到 前台
		// TODO
		String sql1 = "SELECT *  FROM t_mcq WHERE mcq_id=? ";
		Object[] params1 = { mcqID };
		DB mydb1 = new DB();
		try {
			mydb1.doPstm(sql1, params1);
			ResultSet rs1 = mydb1.getRs();
			String mcq_title = null;
			String mcq_optionA = null;
			String mcq_optionB = null;
			String mcq_optionC = null;
			String mcq_optionD = null;
			String mcq_answer = null;
			String url = null;
			while (rs1.next()) {
				mcq_title = rs1.getString("mcq_title");
				mcq_optionA = rs1.getString("mcq_optionA");
				mcq_optionB = rs1.getString("mcq_optionB");
				mcq_optionC = rs1.getString("mcq_optionC");
				mcq_optionD = rs1.getString("mcq_optionD");
				mcq_answer = rs1.getString("mcq_answer");
				url=rs1.getString("url");
			}
			rs1.close();
			req.setAttribute("mcq_title", mcq_title);
			req.setAttribute("mcq_optionA", mcq_optionA);
			req.setAttribute("mcq_optionB", mcq_optionB);
			req.setAttribute("mcq_optionC", mcq_optionC);
			req.setAttribute("mcq_optionD", mcq_optionD);
			req.setAttribute("mcq_answer", mcq_answer);
			req.setAttribute("url", url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb1.closed();

		

		if (user != null) {
			// String classID=req.getParameter("classID");
			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("mcqID", mcqID);
			System.out.println("***这是测试是否进入mcqReuse：quizID是 " + quizID + "attemptID是 " + attemptID + "mcqID是 " + mcqID);
			req.getRequestDispatcher("/page/reuseMcq.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}
	public void mcqEdit(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String mcqID = req.getParameter("mcqID");

		// 查数据库 放到 前台
		// TODO
		String sql1 = "SELECT *  FROM t_mcq WHERE mcq_id=? ";
		Object[] params1 = { mcqID };
		DB mydb1 = new DB();
		try {
			mydb1.doPstm(sql1, params1);
			ResultSet rs1 = mydb1.getRs();
			String mcq_title = null;
			String mcq_optionA = null;
			String mcq_optionB = null;
			String mcq_optionC = null;
			String mcq_optionD = null;
			String mcq_answer = null;
			String url = null;
			while (rs1.next()) {
				mcq_title = rs1.getString("mcq_title");
				mcq_optionA = rs1.getString("mcq_optionA");
				mcq_optionB = rs1.getString("mcq_optionB");
				mcq_optionC = rs1.getString("mcq_optionC");
				mcq_optionD = rs1.getString("mcq_optionD");
				mcq_answer = rs1.getString("mcq_answer");
				url=rs1.getString("url");
			}
			rs1.close();
			req.setAttribute("mcq_title", mcq_title);
			req.setAttribute("mcq_optionA", mcq_optionA);
			req.setAttribute("mcq_optionB", mcq_optionB);
			req.setAttribute("mcq_optionC", mcq_optionC);
			req.setAttribute("mcq_optionD", mcq_optionD);
			req.setAttribute("mcq_answer", mcq_answer);
			req.setAttribute("url", url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb1.closed();

		

		if (user != null) {
			// String classID=req.getParameter("classID");
			req.setAttribute("quizID", quizID);
			req.setAttribute("attemptID", attemptID);
			req.setAttribute("mcqID", mcqID);
			System.out.println("***这是测试是否进入mcqEdit：quizID是 " + quizID + "attemptID是 " + attemptID + "mcqID是 " + mcqID);
			req.getRequestDispatcher("/page/editMcq.jsp").forward(req, res);
		} else {
			req.getRequestDispatcher("page/login.jsp").forward(req, res);
		}

	}

	public void reuseEditing(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Tuser user = (Tuser) req.getSession().getAttribute("user");
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");
		String mcqID = req.getParameter("mcqID");

		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		System.out.println("***这是测试是否进入reuseEditing：quizID是 " + quizID + "attemptID是 " + attemptID + "mcqID是 " + mcqID);
		Tmcq mcqResult = new Tmcq();

		String sql = " select mcq_id, mcq_title, mcq_optionA, mcq_optionB, mcq_optionC, mcq_optionD, mcq_answer, url "
				+ " from t_mcq where 1=1 and mcq_id=?";
		Object[] params = { mcqID };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {

				mcqResult.setMcqID(rs.getString("mcq_id"));

				mcqResult.setMcqTitle(rs.getString("mcq_title"));
				mcqResult.setOptionA(rs.getString("mcq_optionA"));
				mcqResult.setOptionB(rs.getString("mcq_optionB"));
				mcqResult.setOptionC(rs.getString("mcq_optionC"));
				mcqResult.setOptionD(rs.getString("mcq_optionD"));
				mcqResult.setCrtAnswer(rs.getString("mcq_answer"));

				mcqResult.setUrl(rs.getString("url"));

				System.out.println("*******被重新编辑的题目:*******\n" + "MCQ ID: " + rs.getString("mcq_id") + "MCQ title: "
						+ rs.getString("mcq_title") + "MCQ A: " + rs.getString("mcq_optionA") + "MCQ B: "
						+ rs.getString("mcq_optionB") + "MCQ C: " + rs.getString("mcq_optionC") + "MCQ D: "
						+ rs.getString("mcq_optionD") + " 正确选项:" + rs.getString("mcq_answer"));

				// mcqResultList.add(mcqResult);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();
		res.getWriter().println(JsonUtil.object2json(mcqResult));

	}

	// *************学生端quiz功能函数*************

	/* 判断学生输入的quiz ID是否存在 */
	public boolean judgeQuizIDExist(HttpServletRequest req, HttpServletResponse res) throws IOException {
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");
		Boolean result = false;
		int judge1=1;//判断是否存在这个attempt，初始值为1，不存在
		int judge2=1;//判断这个attempt是否enabled，初始值为1，disabled
		String attemptID = req.getParameter("quizID"); // 学生输入的ID其实是attempt ID
		String sql1 = " select * from t_quiz aa " + " where 1=1 and aa.attempt_id=? ";
		String status=null;
		String enabled="enabled";
		if (liuService.judgeIDExist(Integer.parseInt(attemptID), sql1) == true) {
		//	res.getWriter().println("success");
		//	result = true;
			judge1=0;//如果找到同一attempt号，则存在该attempt，judge1设为0；
		} else {
			res.getWriter().println("Quiz doesn't exist.");
			result=false;
			return result;
		}
		
		String sql2=" select status from t_quiz aa " + " where 1=1 and aa.attempt_id=? ";
		Object[] params = { attemptID };
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
			res.getWriter().println("Quiz is disabled.");
			result=false;	
		}
			
		
		return result;
		
	}

	public void studentQuizDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		// 先根据学生输入的attemptID获得quizID
		String attemptID = req.getParameter("attemptID");
		String quizID = null;

		String sql1 = "select quiz_id from t_quiz where 1=1 and attempt_id=?";
		Object[] params1 = { attemptID };
		DB mydb1 = new DB();
		try {
			mydb1.doPstm(sql1, params1);
			ResultSet rs1 = mydb1.getRs();
			while (rs1.next()) {
				quizID = rs1.getString("quiz_id");
			}
			rs1.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb1.closed();

		// 再根据quizID找到该quiz中的所有mcq
		List mcqContentList = new ArrayList();
		String sql = " select bb.mcq_id, bb.mcq_title, bb.mcq_optionA, bb.mcq_optionB, bb.mcq_optionC, bb.mcq_optionD, bb.url"
				+ " from t_quizhasmcq aa join t_mcq bb on aa.mcq_id=bb.mcq_id where 1=1 and aa.quiz_id=?"
				+ " order by aa.relation_id";
		Object[] params = { quizID };

		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tmcq mcqContent = new Tmcq();
				mcqContent.setMcqID(rs.getString("mcq_id"));
				mcqContent.setMcqTitle(rs.getString("mcq_title"));
				mcqContent.setOptionA(rs.getString("mcq_optionA"));
				mcqContent.setOptionB(rs.getString("mcq_optionB"));
				mcqContent.setOptionC(rs.getString("mcq_optionC"));
				mcqContent.setOptionD(rs.getString("mcq_optionD"));
				mcqContent.setUrl(rs.getString("url"));
				mcqContentList.add(mcqContent);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.getSession().setAttribute("mcqContentList", mcqContentList);
		req.setAttribute("attemptID", attemptID);
		req.setAttribute("quizID", quizID);
		req.getRequestDispatcher("student/stuQuizDetail.jsp").forward(req, res);

	}

	public void answerAdd(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/plain");
		req.setCharacterEncoding("utf-8");
		res.setCharacterEncoding("utf-8");

		// 获取ip地址
		String stuIP = getClientIp(req);
		String quizID = req.getParameter("quizID");
		String attemptID = req.getParameter("attemptID");

		if (liuService.queryHasSubmitAnswer(stuIP, attemptID) == true) {
			req.getRequestDispatcher("student/error.jsp").forward(req, res);
		} else {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");

			List mcqContentList = (List) req.getSession().getAttribute("mcqContentList");
			for (int i = 0; i < mcqContentList.size(); i++) {
				Tmcq mcq = (Tmcq) mcqContentList.get(i);
				String mcqID = mcq.getMcqID(); // 获取题目的mcqID
				String stuOption = req.getParameter(String.valueOf(mcq.getMcqID())); // 获取学生对题目的选项
				String stuOptionField = "option" + stuOption + "_count";

				// 在此数据库操作：在t_answer表中对该问题的回答数进行更新，即将学生所选的那个选项的数目加1
				String sql1 = " update t_answer " + " set " + stuOptionField + "=" + stuOptionField + "+1"
						+ " where mcq_id=? and quiz_id=? and attempt_id=?";

				Object[] params1 = { mcqID, quizID, attemptID };
				DB mydb1 = new DB();
				try {
					mydb1.doPstm(sql1, params1);
				} catch (Exception e) {
					e.printStackTrace();
				}
				mydb1.closed();
			}
			// 在此数据库操作：在t_student表中插入学生ip对该attempt的回答记录
			liuService.stuAdd(getClientIp(req), attemptID, df.format(new Date()));
			req.getRequestDispatcher("student/hasdone.jsp").forward(req, res);
		}
	}

	// 获取学生ip地址
	public static String getClientIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public void dispatch(String targetURI, HttpServletRequest request, HttpServletResponse response) {
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(targetURI);
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
