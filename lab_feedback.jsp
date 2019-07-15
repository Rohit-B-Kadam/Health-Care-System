<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<html>
<head>
<title> Schedule  </title> 
<style>

input.buttonColor {
    background-color: #ffa500;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 4px;
}

input.button2:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}

div.top {
	background-color: white;
	width: 1000px;
	height: 50px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}

div.inner
 {
	background-color: white;
	width: 1000px;
	height: 50px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	margin:5px;
	

}

div.inner:hover {
	border: 2px solid #ffffff;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
tr.spaceUnder>td {
  padding-bottom: 15px;
}


body{
	margin:0;
}

input.logoutButton {
    background-color: orange;
    border: none;
    color: white;
    padding: 8px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 4px;
}

.topnav
{
	overflow: hidden;
	background-color: #333;
	border: 0px solid #ffffff;
	padding: 2px;
	height : 50px;
	float: left;
	color : white;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 17px;
	position: fixed;
}

input.button3:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	 background-color: red;
}

</style>

</head>

<body bgcolor="orange">
<%
	if(session.getAttribute("lab_id")==null)
	{
		response.sendRedirect("login_page.jsp");	
	}
%>

<div class="topnav">
	<form action="lab_logout.jsp" method="GET">
	<table>
		<tr>
			<td style=' width:80em;' ><font size=5 ><a href="lab_technician_homepage.jsp" style="color: white; text-decoration:none;">HEALTH CARE SYSTEM</a></font></td>
			<td style=' width:15em;'  ><p> <%=session.getAttribute("name")%></p></td>
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton button3"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>
<br>
<center> <h1> &#10012 Check Feedback &#10012</h1></center>
<center>
<br>
<div class="top">
	<table >
		<th style=" width:15em; padding:5px;">PATIENTS NAME</th>
		<th style=" width:15em; padding:5px;">APPOINTMENT DATE</th>
		<th style=" width:15em; padding:5px;">APPOINTMENT TIME</th>
		<th style=" width:15em; padding:5px;">FEEDBACK</th>
	</table>
</div>
<br>
<br>


<!-- JSP -->




<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%
	
if(request.getMethod().equalsIgnoreCase("GET"))
{
	String labID = (String)session.getAttribute("lab_id");
	String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		//check this query
		sql ="select DT.*,P.name from Diagnostic_Tests as DT  ,  Patients as P where DT.lab_id = "+labID+" and DT.patient_id = P.patient_id;";
		rs = st.executeQuery(sql);
		while(rs.next())
		{

			out.print("<div class='inner'>");
			out.print("<from action=# method='POST'>");
			out.print("	<table>");			
			out.print("		<td style=' width:15em; padding:5px;'><center>"+rs.getString("name")+"</center></td>");
			out.print("		<td style=' width:15em; padding:5px;'><center>"+rs.getString("appointment_date")+"</center></td>");
			out.print("		<td style=' width:15em; padding:5px;'><center>"+rs.getString("appointment_time")+"</center></td>");
			out.print("		<td style='width:15em; padding:5px;'><center>"+rs.getString("feedback")+"</center></td>");
			out.print("<input type='hidden' name='ap_no' value='"+rs.getString(1)+"'></td>");
			out.print("	</table>");
			out.print("</form>");
			out.print("</div>");
		}
	}catch(Exception error){
		out.print("Error: "+error);	
	}
}

%>		

</center>
</body>
</html>
