<html>
<head>
<title> Consultation Page </title> 
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
	width: 800px;
	height: 300px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	margin-top:5px;

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
	if(session.getAttribute("doctor_id")==null)
	{
		response.sendRedirect("login_page.jsp");	
	}
%>
<div class="topnav">
	<form action="doctor_logout.jsp" method="GET">
	<table>
		<tr>
			<td style=' width:80em;' ><font size=5 ><a href="doctors_homepage.jsp" style="color: white; text-decoration:none;">HEALTH CARE SYSTEM</a></font></td>
			<td style=' width:15em; color:white;'  ><p> <%=session.getAttribute("name")%></p></td>
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton button3"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>

<center> <h1> Consultation </h1></center>

<center>

<br><br><br>


<!-- JSP -->

<%@ page import="java.sql.*" %>

<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%

if(request.getMethod().equalsIgnoreCase("GET"))
{
	String doctorId = (String)session.getAttribute("doctor_id");
	String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		//check this query
		sql = "select * from  Consults where problem_type = ( select specialization from Doctors where doctor_id = '"+doctorId+"' ) and  consult_no NOT IN ( select consult_id from Answers where doctor_id = '"+doctorId+"' ); ";
		//out.print(sql);
		rs = st.executeQuery(sql);
		while(rs.next())
		{
			out.print("<div class='top'>");
			out.print("<form action=reply_answer.jsp method='GET'>");
			out.print("<table>");
			out.print("	<tr class='spaceUnder' >");
			out.print("		<td> Title </td>");
			out.print("		<td style=' padding-left: 3em; width:30em; height:2em'> <p><b>"+rs.getString(3)+" </b></p> </textarea></td>");
			out.print("	</tr>");
			out.print("	<tr class='spaceUnder' >");
			out.print("		<td>Description:</td>");
			out.print("		<td style=' padding-left: 3em; width:30em; height:8em;' ><p>"+rs.getString(4)+"</p></td>");
			out.print("	</tr>");
			out.print("	<tr class='spaceUnder'>");
			out.print("		<td><input type='hidden' name='consult_no' value='"+rs.getString(1)+"'></td>");
			out.print("		<td style=' padding-left: 3em; '><input type='submit' name='submit' value='Give Answer' class='buttonColor button2'></td>");
			out.print("	</tr>");
			out.print("</table>");
			out.print("</form>");
			out.print("</div>");
		}
		out.print("<font color='red'>NO MORE DATA</font>");			
	}catch(Exception error){}
}
%>
</center>
</body>
</html>
