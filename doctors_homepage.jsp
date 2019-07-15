<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>Doctors Homepage</title>

<style>

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
	<center><h1><font size="8">Home Page</font> </h1></center>
	<hr>
	<br>
	<br>

	<form action="schedule.jsp" method="GET">
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
	
	<form action="doctor_consultation.jsp" method="GET">
		<tr >
			<td align="Left" ><font size="5"><h3>2. Consultations</h3></font></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> view patient question and give answer </td>
			<td></td>			
			<td > <input type="submit" name="submit" value="View Question"  style="width:200px;" > </td>	
		</tr>
	</form>
	
	<form action="doctor_view_record.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">3. View Patients Report </font></h3></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4">view patient record</td>
			<td></td>			
			<td > <input type="submit" name="submit" value="View" style="width:200px;" > </td>	
		</tr>
	</form>
	<form action="doctor_feedback.jsp" method="GET">
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
