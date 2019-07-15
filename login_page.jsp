<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title> Login Page </title> 
<script type="text/javascript">

function validationForm()
{
	var email = document.forms["loginForm"]["email"].value;
	var password = document.forms["loginForm"]["password"].value;
	var choice = document.getElementsByName("choice");
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
		
	
	if(email=="" )
	{
		alert("Fill complete Form");
		return false;	
	}
	else if(password.length < 4 )
	{
		alert("Password can't be small");
		return false;	
	}
	
	var patt = /^([A-Za-z0-9](\.)?(\-)?)+([A-za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-za-z0-9])+\.([A-za-z0-9]{2,4})$/;	
	
	if(! patt.test(email) )
	{
		alert("email invalid");
		return false;	
	}
}
</script>
</head>

<body background="Image/login2.jpg">
<h1><center><font color=#14BEF0> &#x271C Health Care &#10012</font></center></h1><br>
<center><h2>Login: </h2>


<form method="POST" name="loginForm" onSubmit="return validationForm();">

<table>
	<tr>
		<td>Email<td>
		<td><input type="email" name="email" size="25" autofocus="true" placeholder="enter email"  required></td>
	</tr>
	<tr>	<td> </td> </tr>
	<tr>
		<td>Password<td>
		<td> <input type="password" name="password" autofocus="true" required size="25" placeholder="enter password" autocomplete="off" > </td>
   	</tr>
</table>
<br>
<h2>Select Type: </h2>
<table>
	<tr>
		<td><input type="radio" name="choice" value="Doctors" ></td>
 		<td><label for="Doctors">Doctor <label></td>
	</tr>
	<tr>
                <td><input type="radio" name="choice" value="Patients"></td>
		<td><label for="Patients">Patient<label></td>
        </tr>
	<tr>
                
                <td><input type="radio" name="choice" value="Diagnostic_Labs"></td>
 		<td><label for="Diagnostic_Labs">Lab Technitian</label></td>
        </tr>
</table>
<br><br>
<table>
	<tr>
		<td > &nbsp; &nbsp; <input type="submit" value="Login"   ></td>
	</tr>
</table>


<form>

<br/>
<!- JSP-->

<%!
	Statement st;
	ResultSet rs;
	Connection con;	
 %>

<%
if(request.getMethod().equalsIgnoreCase("POST"))
{
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String choice = request.getParameter("choice");
	String sql = "select * from "+choice+" where email = '"+email+"' and password = '"+password+"';";
	try{
		
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st=con.createStatement();
        	rs=st.executeQuery(sql);
		if(rs.next())
		{

			session.setAttribute("email",email);
			session.setAttribute("name",rs.getString(2));

			
			if(choice.equals("Doctors"))
			{
				session.setAttribute("doctor_id",rs.getString(1));
				response.sendRedirect("doctors_homepage.jsp");
			}
			else if(choice.equals("Patients"))
			{
				session.setAttribute("patient_id",rs.getString(1));
                                response.sendRedirect("patients_homepage.jsp");
			}
			else if(choice.equals("Diagnostic_Labs"))
			{
				session.setAttribute("lab_id",rs.getString(1));
                                response.sendRedirect("lab_technician_homepage.jsp");
			}


		}
		else
		{
			//out.print("<center> <font color='red' > !email and password not found </font></center> ");
			%>
				<script>
						alert("Invalid email or password ");
				</script>
			<%
		}
	}catch(Exception error)
	{}
	
}	
%>


<br><br><br><br><br><br><br>
<h2>Registration For: </h2><br>
<a href="doctor_registration.jsp"> Doctor </a><br>
<a href="patient_registration.jsp"> Patient </a><br>
<a href="lab_technician_registration.jsp"> Lab Technician </a><br>
</center>


</body>
</html>
