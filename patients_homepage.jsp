<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient HomePage</title>

<style>

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

input.button2:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
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

.mySlides {display:none;}

</style>




</head>
<body bgcolor="#14BEF0">

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
	<center><h1><font size="7">Your Home For Health</font> </h1></center>
	<br>	
	<hr>

<!--

<div class="w3-content w3-section" style="width:100%; height: 300px; margin:0px">
  <img class="mySlides" src="Image/Caring-Doctors-in-Hong-Kong.jpg" style="width:100%; height: 300px;">
  <img class="mySlides" src="Image/1.jpg" style="width:100%; height: 300px;">
  <img class="mySlides" src="Image/2.jpg" style="width:100%; height: 300px;">
</div>

<script type="text/javascript" >
var myIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";  
    }
    myIndex++;
    if (myIndex > x.length) {myIndex = 1}    
    x[myIndex-1].style.display = "block";  
    setTimeout(carousel, 5000); // Change image every 2 seconds
}
</script>
-->

	<form action="search_doctor_lab.jsp" method="GET">
	<table>
		<tr>
			<th align="Left" ><font size="5"> <h3>1. Book Appointments And Lab Tests </h3></font></th>
			<td style="padding-left: 7em;"></td>
			<th></th>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> Find doctors and trusted diagnostic labs</font></td>
			<td></td>			
			<td > <input type="submit" name="submit" value="Find me right doctor" style="width:200px;" > </td>	
		</tr>
	</form>
	

	<form action="ask_question.jsp" method="GET">
		<tr >
			<td align="Left" ><font size="5"><h3>2. Consult A Doctor</h3></font></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> Get answers from doctors to any health problem </td>
			<td></td>			
			<td > <input type="submit" name="submit" value="Ask a doctor"  style="width:200px;" > </td>	
		</tr>
	</form>
	
	<form action="check_consulation.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">3. My Online Consultations </font></h3></td>
			<td></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4">View the answer given by doctor</td>
			<td></td>			
			<td > <input type="submit" name="submit" value="View Doctor reply" style="width:200px;" > </td>	
		</tr>
	</form>
	
	<form action="patient_record.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">4. My Medical Record </font></h3></td>
			<td ></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> view your all medical record given by lab</td>
			<td></td>			
			<td > <input type="submit" name="submit" value=" View the record " style="width:200px;" > </td>	
		</tr>
	</form>

	<form action="checkAppointment.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">5. Check Appointment  
				<select name="type">
					<option value="doctor">doctor</option>
					<option value="lab">Lab</option>				
				</select>		
				</font></h3>		
			</td>
			<td ></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> check your all appointments </td>
			<td></td>			
			<td > <input type="submit" name="submit" value=" check " style="width:200px;" > </td>	
		</tr>
	</form>

	<form action="give_feedback.jsp" method="GET">
		<tr>
			<td align="Left" ><h3><font size="5">6. Give Feedback 
				<select name="type">
					<option value="doctor">doctor</option>
					<option value="lab">Lab</option>				
				</select>		
				</font></h3>
			</font></h3></td>
			<td ></td>
			<td></td>
		</tr>
		<tr class="spaceUnder">
			<td class="spaceLeft"><font size="4"> Tell about your experience with doctor and lab</td>
			<td></td>			
			<td > <input type="submit" name="submit" value=" check " style="width:200px;" > </td>	
		</tr>
	</table>
	</form>
</html>
