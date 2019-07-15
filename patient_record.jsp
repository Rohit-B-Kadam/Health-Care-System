<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title> Patient Report Page </title> 

<style>

input.buttonColor {
    background-color: #14BEF0;
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

div.inner{
	background-color: white;
	width: 800px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:20px;
    	padding-bottom:20px;
    	padding-left:20px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	box-sizing: border-box;
	margin-top: 20px;
}


tr.spaceUnder>td {
  padding-bottom: 15px;
}

body{
	margin:0;
}

input.logoutButton {
    background-color: #14BEF0;
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


</style>
</head>

<body bgcolor=#14BEF0>

<%
	if(session.getAttribute("patient_id")==null)
	{
		response.sendRedirect("login_page.jsp");	
	}
%>

<div class="topnav">
	<form action="patient_logout.jsp" method="GET">
	<table>
		<tr>
			<td style=' width:70em;' ><font size=5 ><a href="patients_homepage.jsp" style="color: white; text-decoration:none;">HEALTH CARE SYSTEM</a></font></td>
			<td style=' width:10em;'  ><p> <%=session.getAttribute("name")%></p></td>
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>

<center>
<h1>Patient Report &#10012</h1><br>

<!-- JSP -->


<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%
	if(request.getMethod().equalsIgnoreCase("GET") )
	//if(request.getParameter("submit").equals("")) // write
	{
		String patientId = (String)session.getAttribute("patient_id");
		String sql;
		try
		{
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
			st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			sql = "select * from Patient_Reports where patient_id = '"+patientId+"';";
			rs = st.executeQuery(sql);
			rs.afterLast(); 
			while(rs.previous())
			{
				out.print("<div class='inner'>");	
				out.print("	<img src='"+rs.getString(2)+"' alt='report' style='width:100%'>");				
				out.print("	 <h3>"+rs.getString(2)+"</h3>");				
				out.print("	<form method='GET' action=#>");				
				out.print("		<input type='hidden' name='reportId' value='"+rs.getString(1)+"'>");				
				out.print("		<input type='submit' name='submit' value='Delete'>");				
				out.print("	</form>");				
				out.print("</div>");				

			}
		}catch(Exception error)
		{
			out.print("Exception");
		}		
	}
%>
<%
	if(request.getParameter("submit").equals("Delete"))
	{
		String reportId = request.getParameter("reportId");
		String sql;
		try
		{
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
			st = con.createStatement();
			sql = "delete from Patient_Reports where report_no = '"+reportId+"';";
			st.execute(sql);
		
		}catch(Exception error)
		{
			out.print("Exception");
		}		
	}
%>
</center>
</body>
</html>
