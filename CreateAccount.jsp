<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.ResultSet %>
<%@ page import = "DBCollection.DBManager" %>

<%!
	
%>

<%
	request.setCharacterEncoding("euc-kr");

	String ID = request.getParameter("ID");
	String IDType = request.getParameter("IDType");
	String guid;
	boolean State = true;

	Class.forName("com.mysql.jdbc.Driver");
	DBManager DBMgr = new DBManager();
	ResultSet rs = null;

	try {
	
		DBMgr.Connecting(application.getInitParameter("jdbcDriverPath"), application.getInitParameter("DBUserID"), application.getInitParameter("DBUserPasswod"), false);

		String[] Labels = {"guid"};
		String Condition = "id=" + ID + " AND idtype=" + IDType;
		rs = DBMgr.ExecuteQuery(DBMgr.CreateSelectQuery("user", Label, Condition);
	
		if(re.next())
		{
			State = false;
		}
		else
		{
			rs = DBMgr.ExecuteQuery(DBMgr.CreateUUIDQuery());
		}

	}
	finally {
		State = false;
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>

<html>
	<head><title>CreateAccount</title></head>
	<body>
		<%
			try{
				if(State)
				{
					if(rs.next())
					{
						guid = ReCombination(rs.getString("UUID()"));
						String Values = "'{0}', '{1}', '{2}');
						Values.replace("{0}", guid);
						Values.replace("{1}", ID);
						Values.replace("{2}", IDType);

						int RowCount = DBMgr.ExecuteUpdate(DBMgr.CreateInserQuery(user, "'guid', 'id', 'idtype'", Values));

						out.print("Result:Success");
						out.print("guid:"+ guid );
					}
					else
					{
						out.print("Result:Fail");
					}
				}
				else
				{
					out.print("Result:Fail");
				}
			}
			finally
			{
				out.print("Result:Fail");
			}
			DBMgr.Release();
		%>
	</body>
</html>
