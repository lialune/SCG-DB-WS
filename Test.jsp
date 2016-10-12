<%@ page contentType = "text/html; charset=euc-kr"
	import = "org.json.simple.*" %>
<%
	JSONObject json = new JSONObject();
	json.put("id", "test");
	json.put("pass", "1234");
	json.put("name", "±èÇö¿ì");

	out.println(json.toJSONString());
%>