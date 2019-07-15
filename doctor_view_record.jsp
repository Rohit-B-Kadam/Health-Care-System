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

<script type="text/javascript">

function validationForm()
{
	var email = document.forms["form1"]["email"].value;
	patt = /^([A-Za-z0-9](\.)?(\-)?)+([A-za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-za-z0-9])+\.([A-za-z0-9]{2,4})$/;	
	
	if(! patt.test(email) || ( email.length > 50))
	{
		alert("email invalid");
		return false;	
	}
		
	return true;
}

</script> 


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

<center>
<h1>Patient Report &#10012</h1><br>

<!-- JSP -->

<form action=# method="POST" name="form1" onSubmit="return validationForm();">
<table border-spacing="15" padding=23px >
	<tr>
		<td>  Patients Email: </td>
		<td><input type="email" name="email" required size="25" autofocus="true"  placeholder="Doctors,Specialities,Test etc"> </td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit"   value="View" ></td>
	</tr>
</table>
</form>
<br>
<br>
<hr>
<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%
	if(request.getMethod().equalsIgnoreCase("POST") )
	//if(request.getParameter("submit").equals("")) // write
	{
		String email = request.getParameter("email");
		String sql;
		try
		{
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
			st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			sql = "select * from Patients where email = '"+email+"';";
			rs = st.executeQuery(sql);
			
			if(rs.next())
			{
				out.print("<div class='inner'>");
				out.print("	<table>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 1em; '> <font color='#14BEF0' size='5px'>"+rs.getString(2)+" </font> </td>");
				out.print("			<td style='padding-left: 5em; '></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >"+rs.getString(8)+" "+rs.getString(9)+" "+rs.getString(10)+" "+rs.getString(11)+"</td>");
				out.print("		</tr>");
				out.print("	</table>");
				out.print("</div>");
						
			
				sql = "select PR.* , P.name from Patient_Reports PR , Patients P where PR.patient_id = P.patient_id AND P.email = '"+email+"';";		
				rs = st.executeQuery(sql);
				rs.afterLast(); 
				while(rs.previous())
				{
					out.print("<div class='inner'>");	
					out.print("	<img src='"+rs.getString(2)+"' alt='report' style='width:100%'>");				
					out.print("	 <h3>"+rs.getString(2)+"</h3>");				
					out.print("</div>");				
	
				}
			}else
				out.print("<font color='read'> !patient not found </font>");
		}catch(Exception error)
		{
			out.print("Exception");
		}		
	}
	
%>

</center>
</body>
</html>
