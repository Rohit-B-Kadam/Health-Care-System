<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
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
<%
	<center><h1><font size="7">Your Home For Health</font> </h1></center>
	<br>	
	<center><h2>Information</h2><br>
<form action=# method="POST" autocomplete = "off">
<table border-spacing="15" padding=23px >
	<tr class="spaceUnder">
		<td> Full Name </td>
		<td><input type="text" name="name" required size="25" autofocus="true" placeholder="Enter Your Name"> </td>
	</tr>
	<tr class="spaceUnder">	
		<td>Gender</td>		
		<td> <input type="radio" name="gender" value="male"> Male
 			<input type="radio" name="gender" value="female">Female
			<input type="radio" name="gender" value="other">Other
		</td>
	</tr>
 	<tr class="spaceUnder">
		<td> DOB(dd,mm,yyyy): </td>
		<td>
			<select name="date" size="1">
			<option value="1"> 1 </option>
			<option value="2"> 2 </option>
			<option value="3"> 3 </option>
			<option value="4"> 4 </option>
			<option value="5"> 5 </option>
			<option value="6"> 6 </option>
			<option value="7"> 7 </option>
			<option value="8"> 8 </option>
			<option value="9"> 9 </option>
			<option value="10"> 10 </option>
			<option value="11">11 </option>
			<option value="12"> 12 </option>
			<option value="13"> 13</option>
			<option value="14"> 14 </option>
			<option value="15"> 15</option>
			<option value="16"> 16 </option>
			<option value="17"> 17 </option>
			<option value="18"> 18 </option>
			<option value="19"> 19 </option>
			<option value="20"> 20 </option>
			<option value="21"> 21 </option>
			<option value="22"> 22</option>
			<option value="23"> 23 </option>
			<option value="24"> 24 </option>
			<option value="25"> 25 </option>
			<option value="26"> 26 </option>
			<option value="27"> 27 </option>
			<option value="28"> 28 </option>
			<option value="29"> 29 </option>
			<option value="30"> 30 </option>
			<option value="31"> 31 </option>
		</select>


		<select name="month" size="1">
			<option value="1"> 1 </option>
			<option value="2"> 2 </option>
			<option value="3"> 3 </option>
			<option value="4"> 4 </option>
			<option value="5"> 5 </option>
			<option value="6"> 6 </option>
			<option value="7"> 7 </option>
			<option value="8"> 8 </option>
			<option value="9"> 9 </option>
			<option value="10"> 10 </option>
			<option value="11">11 </option>
			<option value="12"> 12 </option>
		</select>


		<select name="year" size="1">
			<option value="1980"> 1980 </option>
			<option value="1981"> 1981 </option>
			<option value="1982"> 1982 </option>
			<option value="1983"> 1983 </option>
			<option value="1984"> 1984 </option>
			<option value="1985"> 1985 </option>
			<option value="1986"> 1986 </option>
			<option value="1987"> 1987 </option>
			<option value="1988"> 1988 </option>
			<option value="1989"> 1989 </option>
			<option value="1990">1990 </option>
			<option value="1991"> 1991 </option>
		</select>
	</td>
	</tr>
	<tr class="spaceUnder">
 		<td>Blood Group</td>
	         <td>   <select name="blood_group" size="1">
                        <option value="O+"> O+ </option>
                        <option value="A+"> A+ </option>
			<option value="B+"> B+ </option>
                        <option value="AB+"> AB+ </option>
			<option value="O-"> O- </option>
                        <option value="A-"> A- </option>
                        <option value="B-"> B- </option>
                        <option value="AB-"> AB- </option>




			</select>
		 </td>
	</tr>
	<tr class="spaceUnder">
		<td>Email</td>
                <td><input type="email" name="email" required size="25" autofocus="true" placeholder="Enter Your Email"></td>
	</tr>
	<tr class="spaceUnder">

		<td>Password</td>
                <td><input type="password" name="password" required size="25" autofocus="true" placeholder="Enter Your Password"></td>
	</tr>
	<tr class="spaceUnder">
		<td>Confirm Password</td>
                <td><input type="password" name="confirmPassword" required size="25" autofocus="true" placeholder="Confirm Password"></td>
	</tr>
	<tr class="spaceUnder">

  		<td>Address</td>
		 <td> street<input name="street" type="text" size=5> area <input name="area" type="text" size="5"> city <input name="city" type="text" size="5"> state <input name="state" type="text" size="5"></td>
	</tr>
	<tr class="spaceUnder">
		<td></td>
		<td><input type="submit" value="Create Account"></td>
	</tr>
</table>
</form>
</center>

<!- JSP -->

<%@ page import="java.sql.*" %>


<%!
        Statement st;
        ResultSet rs;
        Connection con;
 %>

<%
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String date = request.getParameter("date");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String blood_group = request.getParameter("blood_group");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmPassword");
	String street = request.getParameter("street");
	String area = request.getParameter("area");
	String city = request.getParameter("city");
	String state = request.getParameter("state");	
	
	String sql;	
	int count=0;
	if( request.getMethod().equalsIgnoreCase("POST"))
	{
		if( name.isEmpty()  || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || street.isEmpty() || area.isEmpty() || city.isEmpty() || state.isEmpty() || gender == null )	
      		{
			out.print("<center> <font color=\"red\" > !Fill complete Form </font> </center>");
	    	}
	    	else if(!password.equals(confirmPassword))
	    	{
			 out.print("<center> <font color=\"red\" > !Password is not matching </font> </center>");
		}
		else
		{
			try
			{
				Class.forName("org.postgresql.Driver");
      	      	  		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
      	          		st=con.createStatement();
      	          		rs=st.executeQuery("select * from Patients");
      	          		while(rs.next())
      	          		{
                       			count++;
      	          		}
				count ++;
	
				sql = "insert into Patients values("+count+",'"+name+"','"+month+"/"+date+"/"+year+"','"+gender+"','"+blood_group+"','"+email+"','"+password+"','"+street+"','"+area+"','"+city+"','"+state+"');";  
              			
				st.execute(sql);
				session.setAttribute("email",email);
				session.setAttribute("name",name);
				session.setAttribute("patient_id",count);
                                response.sendRedirect("patients_homepage.jsp");

        		}catch(Exception error){}
	
	    	}
	}

%>


</body>
</html>
