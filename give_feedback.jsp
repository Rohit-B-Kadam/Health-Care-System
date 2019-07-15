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
    background-color:#14BEF0;
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

div.top {
	background-color: white;
	width: 1000px;
	height: 40px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}

.inner
 {
	background-color: white;
	width: 1000px;
	height: 100px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	margin:5px;
	

}

inner:hover {
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
<center> <h1> &#10012 Give Feedback &#10012</h1></center>
<center>

<div class="top">
	<table >
		<th style=" width:25em; padding:5px;">DOCTOR NAME</th>
		<th style=" width:35em; padding:5px;">GIVE FEEDBACK</th>
		<th style=" width:10em; padding:5px;">RATING</th>
		<th style=" width:30em; padding:5px;"></th>
	</table>
</div>
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
	String patientId = (String)session.getAttribute("patient_id");
	String type = request.getParameter("type");
	String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		
		//check this query
		if(type.equals("doctor"))
		{
			sql ="select DA.*,D.name,D.review from Doctor_Appointments as DA , Doctors as D where DA.patient_id = "+patientId+" and DA.doctor_id = D.doctor_id;";
			//out.print(sql);
		}
		else
			sql = "select DT.*,D.name,D.review from Diagnostic_Tests as DT , diagnostic_labs as D where DT.patient_id = "+patientId+" and DT.lab_id = D.lab_id;";
			
		rs = st.executeQuery(sql);
		while(rs.next())
		{
			if( rs.getString(4).isEmpty())
			{
			out.print("<div class='inner'>");
			out.print("<form action='submit_feedback.jsp' method='POST'>");
			out.print("	<table>");			
			out.print("		<td style=' width:20em; padding:5px;'><center>"+rs.getString("name")+"</center></td>");
			out.print("		<td style='width:25em; padding:5px;'><center> <textarea name='feedback' style='width: 22em; height: 7em; '  placeholder='Give Feedback'></textarea> </center>");
			out.print("<input type='hidden' name='ap_no' value='"+rs.getString(1)+"'>");
			out.print("<input type='hidden' name='review' value='"+rs.getString("review")+"'>");
			out.print("<input type='hidden' name='id' value='"+rs.getString(6)+"'>");
			out.print("<input type='hidden' name='text' value='"+type+"'></td>");
			%>
				<td style=" width:10em; padding:5px;" >
					<select name="rating">
						<option value="5">  5  </option>
						<option value="4">  4  </option>
						<option value="3">  3  </option>
						<option value="2">  2  </option>
						<option value="1">  1  </option>
					</select>
				</td>
			<%
			
			//out.print("		<td style='width:5em; padding:5px;'><center> <input class='buttonColor button2' type= 'submit' > </center></td>");
			%>
				<td style="width:5em; padding:5px;"><center> <input class="buttonColor button2" type='submit' >	
			<%			
			out.print("	</table>");
			out.print("</form>");
			out.print("</div>");
			}
		}
	}catch(Exception error){
		out.print("Error: "+error);	
	}
}

%>		

</center>
</body>
</html>
