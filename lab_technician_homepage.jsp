<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>Lab Technician Homepage</title>

<style>

body{
	margin:0;
}

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

.input.button2:hover {
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


tr.spaceUnder>td {
  padding-bottom: 15px;
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
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>
	<center><h1><font size="8">Home Page</font> </h1></center>

	<br>
	<hr>
	<br>
	<form action="schedule_lab.jsp" method="GET">
	<table>
		<tr>
			<th align="Left" ><font size="5"> <h3>1. View Schedule</h3></font></th>
			<td style="padding-left: 7em;"></td>
			<th></th>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> view your daily schedule</font></td>
			<td></td>			
			<td > <input type="submit" name="submit" value="Check Schedule" style="width:200px;" > </td>	
		</tr>
	</form>
	
	<form action="add_patient_report.jsp" method="GET">
		<tr >
			<td align="Left" ><font size="5"><h3>2. Add Patient Report</h3></font></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> add patients report </td>
			<td></td>			
			<td > <input type="submit" name="submit" value="Add report"  style="width:200px;" > </td>	
		</tr>
	</form>
	
	<form action="lab_feedback.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">4. Feedback </font></h3></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4">check feedback from patients</td>
			<td></td>			
			<td > <input type="submit" name="submit" value="Check" style="width:200px;" > </td>	
		</tr>
	</form>
	

</html>
