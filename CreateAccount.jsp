<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "DBCollection.DBManager" %>

<%!
	
%>

<%
	request.setCharacterEncoding("euc-kr");

	String ID = request.getParameter("ID");
	String IDType = request.getParameter("IDType");
	String guid;
	boolean State = true;

	DBManager DBMgr = new DBManager();
	ResultSet rs = null;
	String TableName = "SCG.user";

	try {
	
		DBMgr.Connecting(application.getInitParameter("jdbcDriverPath"), application.getInitParameter("DBUserID"), application.getInitParameter("DBUserPassword"), false);

		String[] Labels = {"guid"};
		String Condition = "id='" + ID + "' AND idtype='" + IDType +"'";
		String Query = DBMgr.CreateSelectQuery(TableName, Labels, Condition);

		rs = DBMgr.ExcuteQuery(Query);

		if(rs.next())
		{
			State = false;
		}
		else
		{
			rs = DBMgr.ExcuteQuery(DBMgr.CreateUUIDQuery());
		}
	}
	catch(SQLException ex)
	{
		State = false;
		DBMgr.Release();
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
						guid = DBMgr.ReCombination(rs.getString("UUID()"));
						String Values = "'{0}', '{1}', '{2}')";
						Values.replace("{0}", guid);
						Values.replace("{1}", ID);
						Values.replace("{2}", IDType);

						int RowCount = DBMgr.ExcuteUpdate(DBMgr.CreateInsertQuery(TableName, "'guid', 'id', 'idtype'", Values));

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
			catch(SQLException ex)
			{
				out.print("Result:Fail");
			}
			finally
			{
				DBMgr.Release();
			}
		%>
	</body>
</html>
