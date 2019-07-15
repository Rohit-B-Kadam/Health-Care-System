	<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title> Search Page </title> 

<style>

div {
	background-color: white;
	width: 800px;
	border: 1px solid #14BEF0;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.inner{
	margin-top: 10px;
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



input.buttonColor {
    background-color: #14BEF0;
    border: none;
    color: white;
    padding: 10px 20px;
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

input.button3:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	 background-color: red;
}

.topnav
{
	overflow: hidden;
	background-color: #333;
	border: 0px solid #ffffff;
	padding: 2px;
	height : 50px;
	width:98%;
	float: left;
	color : white;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 17px;
	position: fixed;
}

</style>
	<script type="text/javascript">
		function validationForm()
		{
			var searchText = document.forms["searchform"]["search"].value;
			var location = document.forms["searchform"]["location"].value;
			var patt = /^([A-Za-z0-9\ ])+$/;
			if(! patt.test(searchText) || ( searchText.length < 4) )
			{
				alert("Give Proper text to search");
				return false;	
			}
			/*
			if(! patt.test(location) || ( location.length < 4) )
			{
				alert("Give Proper text for searching location");
				return false;	
			}
			*/
			var choice = document.getElementsByName("type");
			var flag = false;
			for( var i = 0 ; i < choice.length ; i++ )
			{
				if(choice[i].checked)
				{
					flag = true;
					break;				
				}
			}
			if(flag == false)
			{
				alert("Select type");
				return false;	
			}			
			return true;		
		}
	</script>
</head>

<body bgcolor=#14BEF0 >

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

<h1><center>&#10012 Search Doctor And Labs &#10012</center></h1>
<center>
<form action=# method="POST" name="searchform" onSubmit="return validationForm();" >
<table border-spacing="15" padding=23px >
	<tr>
		<td>  Search </td>
		<td><input type="text" name="search" required size="25" autofocus="true"  placeholder="Doctors,Specialities,Test etc"> </td>
	</tr>
	 <tr>
                <td>  Location </td>
                <td><input type="text" name="location" required size="20" autofocus="true"  placeholder="Location"> </td>
        </tr>

<tr>
<td></td>
<td> <input type="radio" name="type" value="doctor" >Doctor
	<input type="radio" name="type" value="lab" >Lab</td>
</tr>
<tr>
	<td></td>
	<td><input type="submit"  value="Search" ></td>
</tr>
</table>
</form>
</center>

<hr>
<center><h3>List (Search nearby doctors)</h3></center>

<!-- JSP -->


<%! 
	Connection con;
	Statement st;
	ResultSet rs;
	ResultSet rs1;
%>

<%

if(request.getMethod().equalsIgnoreCase("POST"))
{
	String type = request.getParameter("type");
	String search = request.getParameter("search");
	String location = request.getParameter("location");
	String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		
		if(type.equals("doctor"))
		{
		
			sql = "select * from Doctors where ( LOWER (name) LIKE LOWER('%"+search+"%') OR  LOWER(specialization) LIKE LOWER('%"+search+"%') ) AND ( LOWER(street) LIKE LOWER('%"+location+"%') OR LOWER(area) LIKE LOWER('%"+location+"%') OR LOWER(city) LIKE LOWER('%"+location+"%') OR LOWER(state) LIKE LOWER('%"+location+"%') );";	
			
			//out.print(sql);			
			
			rs = st.executeQuery(sql);
			out.print("<center>");
			while(rs.next())
			{
				out.print("<div class ='inner'>");
				out.print("	<form action='doctor_appointment_booking.jsp' method='GET'>");
				out.print("		<Table>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 1em; '> <font color='#14BEF0' size='5px'>"+rs.getString(2)+" </p> </td>");
				out.print("			<td style='padding-left: 5em; '></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 3em;' >"+rs.getString(5) +"</td>");
				out.print("			<td></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 3em;' >"+rs.getString(4) +"</td>");
				out.print("			<td></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >"+rs.getString(9)+" "+rs.getString(10)+" "+rs.getString(11)+" "+rs.getString(12)+"</td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >Rating: "+rs.getString(13)+"</td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td> <input type='hidden' name='drID' value='"+rs.getString(1)+"'></td>");
				out.print("			<td style='float: right; padding-left: 2em; ' > <input type='submit' value='Book Appointment' class='buttonColor button2 ' ></td>");
				out.print("		<tr>");
				out.print("		</table>");
				out.print("	</form>");
				out.print("</div>");
			}	
			out.print("</center>");
		}
		else 
		{
			sql = "select * from Diagnostic_Labs where ( LOWER (street) LIKE LOWER('%"+location+"%') OR LOWER(area) LIKE LOWER('%"+location+"%') OR LOWER(city) LIKE LOWER('%"+location+"%') OR LOWER(state) LIKE LOWER('%"+location+"%')) AND (lab_id in(select lab_id from Test_Provider where test_id in (select test_id from Tests where LOWER(test_name) LIKE LOWER('%"+search+"%'))));";
			
			rs = st.executeQuery(sql);
			out.print("<center>");
                        while(rs.next())
                        {
                        	out.print("<div class='inner'>");
				out.print("	<form action='lab_test_booking.jsp' method='GET'>");
				out.print("		<Table>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 1em; '> <font color='#14BEF0' size='5px'>"+rs.getString(2)+" </p> </td>");
				out.print("			<td style='padding-left: 5em; '></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >"+rs.getString(5)+" "+rs.getString(6)+" "+rs.getString(7)+" "+rs.getString(8)+"</td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >Rating: "+rs.getString(9)+"</td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td> <input type='hidden' name='drID' value='"+rs.getString(1)+"'>");							
				out.print("</td>");
				out.print("			<td style='float: right; padding-left: 2em; ' > <input type='submit' value='Book Appointment'  class='buttonColor button2 '></td>");
				out.print("		<tr>");
				out.print("		</table>");
				out.print("	</form>");
				out.print("</div>");	
                        }
			out.print("</center>");

		}		
	}catch(Exception error){}
	
}


%>

</body>
</html>
