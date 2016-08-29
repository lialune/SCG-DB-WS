<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.ResultSet %>

<%
	request.setCharacterEncoding("euc-kr");

	String ID = request.getParameter("ID");
	String IDType = request.getParameter("IDType");
	String guid;

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
	String jdbcDriver = application.getInitParameter("jdbcDriverPath") + "useUnicode=true&characterEncoding=euckr";
	String dbUser = application.getInitParameter("DBUserID");
	String dbPass = application.getInitParameter("DBUerPassword");
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	conn.setAutoCommit(false);
	pstmt = conn.prepareStatement("select guid from user WHERE id=" + ID + " AND idtype=" + IDType);

	rs = pstmt.executeUpdate();

	}finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>

<html>
	<head>LoggedIn</head>
	<body>
		<%
			if(rs.next())
			{
				out.print("Result:Success");
				out.print("guid:"+ rs.getString("guid"));
			}
			else
			{
				out.print("Result:Fail");
			}
		%>
	</body>
</html>
