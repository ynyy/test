package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DB
{
	private Connection con;

	private PreparedStatement pstm;
	
	/*学校的是3309就改为3309，是多少就改多少*/
//	private String url = "jdbc:mysql://localhost:3306/jplecture_20180809?useUnicode=true&characterEncoding=utf8";
//
//	private String user = "root";
//
//	private String password = "9766zyxfdbs";

	private String url = "jdbc:mysql://localhost:3306/jpsearch?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

	private String user = "root";

	private String password ="newrootpassword";

	private String className = "com.mysql.cj.jdbc.Driver";
	
	public DB()
	{
		try
		{
			Class.forName(className);
		} catch (ClassNotFoundException e)
		{
			System.out.println("Class not found.(DB.java)");
			e.printStackTrace();
		}
	}

	/*Get database connection*/
	public Connection getCon()
	{
		try
		{
			if (con == null){
			con = DriverManager.getConnection(url, user, password);
			}
		} catch (SQLException e)
		{
			System.out.println("SQLException e");
			con = null;
			e.printStackTrace();
		}
		return con;
	}

	public void doPstm(String sql, Object[] params)
	{
		if (sql != null && !sql.equals(""))
		{
			if (params == null)
				params = new Object[0];
			
			   getCon();
			
			if (con != null)
			{
				try
				{
					System.out.println(sql);
					pstm = con.prepareStatement(sql,
							ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CONCUR_READ_ONLY);
					for (int i = 0; i < params.length; i++)
					{
						pstm.setObject(i + 1, params[i]);
					}
					pstm.execute();
				} catch (SQLException e)
				{
					System.out.println("doPstm()Exception");
					e.printStackTrace();
				}
			}
		}
	}

	public ResultSet getRs() throws SQLException
	{
		return pstm.getResultSet();
	}

	public int getCount() throws SQLException
	{
		return pstm.getUpdateCount();
	}

	public void closed()
	{
		try
		{
			if (pstm != null)
				pstm.close();
		} catch (SQLException e)
		{
			System.out.println("Closed Exception1");
			e.printStackTrace();
		}
		try
		{
			if (con != null)
			{
				con.close();
			}
		} catch (SQLException e)
		{
			System.out.println("Closed Exception1");
			e.printStackTrace();
		}
	}
}
