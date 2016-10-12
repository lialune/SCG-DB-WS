<%@ page contentType = "text/html; charset=euc-kr"
	import = "org.json.simple.*" 
	import = "java.sql.DriverManager"
import = "java.sql.Connection"
import = "java.sql.Statement"
import = "java.sql.SQLException"
import = "java.sql.ResultSet" %>

<%

Connection Conn;
	Statement Stmt;
	ResultSet rs;

	Class.forName("com.mysql.jdbc.Driver");

	String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/SCG?" + "useUnicode=true&characterEncoding=euckr";

	Conn = DriverManager.getConnection(jdbcDriver, "root", "lialune26");
	Conn.setAutoCommit(false);
	Stmt = Conn.createStatement();
	rs = Stmt.executeQuery("SELECT 'guid' FROM SCG.user WHERE id='1234' AND idtype='F'");

	if(rs.next())
	{
		int a = 10;
	}

	out.print("hi!!!");
	rs.close();
	Stmt.close();
	Conn.close();

%>