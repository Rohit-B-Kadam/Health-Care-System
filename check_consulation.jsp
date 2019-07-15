<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title> My Online Consultations </title> 
<style>

input.buttonColor {
    background-color: #14BEF0;
    border: none;
    color: white;
    padding: 12px 30px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 4px;
    width:100px;
}

input.button2:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}

div.question
{
	background-color: white;
	width: 99%;
	height: 40px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	margin-bottom:20px;
	
}

div.answer
{
	background-color: white;
	width: 90%;
	border: 1px solid black;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	margin-left:90px;
	overflow:auto;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	
}
div.answerHower:hover{
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

div.outer{
	background-color: white;
	width: 1000px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	margin-top:3px;
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

input.button3:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	 background-color: red;
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
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton button3"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>


<font color="black"><center><h1>&#10012 My Online Consultations &#10012</h1></center></font><br>
<center>



<!-- JSP -->


<%! 
	Connection con;
	Statement st1,st2,st3;
	ResultSet rs1,rs2;
%>

<%

if(request.getParameter("submit").equals("View Doctor reply"))
{
	String patientId = (String)session.getAttribute("patient_id");
	String sql1;
	String sql2;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st1 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY); 
										//ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY
		st2 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		
		sql1 = "select * from  Consults where patient_id = '"+patientId+"'; ";
		rs1 = st1.executeQuery(sql1);
		rs1.afterLast(); 
		while(rs1.previous())
		{
			out.print("<div class='outer'>");
			
			out.print("		<div class='question'>");
			out.print("			<p align='left' style='padding-left:3em;'><b>Question: "+rs1.getString(4)+" </b></p>");
			out.print("		</div>");
			
			
			sql2="select A.* , D.name from Answers as A, Doctors as D where A.consult_id ='"+rs1.getString(1)+"' AND A.doctor_id = D.doctor_id ;";			
			rs2 = st2.executeQuery(sql2);
			while(rs2.next())
			{ 
				out.print("		<div class='answer'>");
				out.print("			 <div style='float:left; width: 80%;'>");
				out.print("				<table>");
				out.print("					<tr class='spaceUnder'>");
				out.print("						<td>Dr. Name </td>");
				out.print("						<td style=' padding-left: 3em; width:500px;'>"+rs2.getString("name")+"</td>");
				out.print("					</tr>");
				out.print("					<tr class='spaceUnder'>");
				out.print("						<td><p align='top'>Answer<p></td>");
				out.print("						<td style=' padding-left: 3em; width:500px;' >"+rs2.getString(2)+"</td>");
				out.print("					</tr>");
				out.print("				</table>");
				out.print("   			</div>");
				out.print("   			<div style='float:right; width:20%;'>");
				out.print("   			</div>");
				out.print("		</div>");
			}
			out.print("</div>");
		}
	
	}catch(Exception error)
	{
		out.print("Exeption: "+error);	
	}
}	
%>
	
</center>
</body>
</html>
