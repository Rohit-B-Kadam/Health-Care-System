<!DOCTYPE html>
<html>
<head>
<style>

tr.spaceUnder>td {
  padding-bottom: 15px;
}



</style>

<script type="text/javascript">


function validationForm()
{
	var choice = document.getElementsByName("gender");
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
		alert("Select Gender");
		return false;	
	}
	var name1 = document.forms["form1"]["name"].value;	
	var patt = /^([A-Za-z\ ])+$/;
	if( (!patt.test(name1)) || ( name1.length > 50))
	{
		alert("Give Proper Name");
		return false;	
	}
	
	var string1 = document.forms["form1"]["qualification"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("Give Proper qualification");
		return false;	
	}	

	string1 = document.forms["form1"]["specialization"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("Give Proper specialization");
		return false;	
	}

	string1 = document.forms["form1"]["hospital_name"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("Give Proper hospital_name");
		return false;	
	}
		
	string1 = document.forms["form1"]["state"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("	Area , City and State can not have Number");
		return false;	
	}
	
	string1 = document.forms["form1"]["area"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("	Area , City and State can not have Number");
		return false;	
	}
	
	string1 = document.forms["form1"]["city"].value;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("	Area , City and State can not have Number");
		return false;	
	}
	
	string1 = document.forms["form1"]["street"].value;
	patt = /^([A-Za-z0-9\ ])+$/;
	if( (!patt.test(string1)) || ( string1.length > 20))
	{
		alert("	Area , City and State can not have Number");
		return false;	
	}

	var email = document.forms["form1"]["email"].value;
	patt = /^([A-Za-z0-9](\.)?(\-)?)+([A-za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-za-z0-9])+\.([A-za-z0-9]{2,4})$/;	
	
	if(! patt.test(email) )
	{
		alert("email invalid");
		return false;	
	}

	string1 = document.forms["form1"]["password"].value;
	var string2 = document.forms["form1"]["confirmPassword"].value;
		
	if( string1 != string2 )
	{
		alert("Password is not matching");
		return false;	
	}
	if(string1.length < 4 || ( string1.length > 20))
	{
		alert("Password can't be small");
		return false;	
	}

	return true;
	
}

</script>

<title> Doctor Registration Page </title> 
</head>

<body background="Image/doctorReg.jpg" style="height:100%">
<h1><center>&#10012 Doctor Registration &#10012</center></h1><br>
<center><h2>Information</h2><br>
<form name="form1" method="POST"  autocomplete = "off" onSubmit="return validationForm();" >
<table border-spacing="15" padding=23px >
	<tr class="spaceUnder">
		<td>  Name </td>
		<td><input type="text" name="name" required size="20" autofocus="true"  placeholder="Name"> </td>
	</tr>


<tr class="spaceUnder">	
		<td>Gender</td>		
		<td> <input type="radio" name="gender" value="male" selected > Male
 			<input type="radio" name="gender" value="female">Female
			<input type="radio" name="gender" value="other">Other
		</td>
	</tr>


 	<tr class="spaceUnder">
		<td>Qualification</td>
                <td><input type="text" name="qualification" required size="25" autofocus="true" placeholder="Qualification"></td>
	</tr>
  <tr class="spaceUnder">
                <td>Specialization</td>
                <td><input type="text" name="specialization" required size="25" autofocus="true" placeholder="Specialization"></td>
        </tr>

<tr class="spaceUnder">
                <td>Hospital Name</td>
                <td><input type="text" name="hospital_name" required size="25" autofocus="true" placeholder="hospital name"></td>
        </tr>



 <tr class="spaceUnder">
	
                <td>Email</td>
                <td><input type="email" name="email" required size="25" autofocus="true" placeholder="Email"></td>
        </tr>

	<tr class="spaceUnder">

		<td>Password</td>
                <td><input type="password" name="password"  required size="25" autofocus="true" placeholder="Enter Your Password"></td>
	</tr>
	<tr class="spaceUnder">
		<td>Confirm Password</td>
                <td><input type="password" name="confirmPassword" required size="25" autofocus="true" placeholder="Confirm Password"></td>
	</tr>
	<tr class="spaceUnder">

  		<td>Address</td>
		 <td> street<input name="street" type="text" size=5> area <input name="area" type="text" size="5"> city <input type="text" name="city" size="5"> state <input name="state" type="text" size="5"></td>
	</tr>
	<tr class="spaceUnder">
		<td></td>
		<td><input type="submit" value="Create Account">
			<input type="reset"> 
			<a href="login_page.jsp"><input type="button" value="Login">
		</td>
	</tr>
</table>
</form>
</center>
<br>
<br>
<br>

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
	String qualification = request.getParameter("qualification");
	String specialization = request.getParameter("specialization");
	String hospital_name = request.getParameter("hospital_name");
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
		if( name.isEmpty() || qualification.isEmpty() || specialization.isEmpty() || hospital_name.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || street.isEmpty() || area.isEmpty() || city.isEmpty() || state.isEmpty() || gender == null )	
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
				
				rs = st.executeQuery("select * from Doctors where email = '"+email+"';");
				if(rs.next())
				{
					%>
						<script> alert("This Email is already exist"); </script>
					<%	
					return;			
				}	
				
      	          		rs=st.executeQuery("select * from Doctors");
      	          		while(rs.next())
      	          		{
                       			count++;
      	          		}
				count ++;
	
				sql = "insert into Doctors values("+count+",'"+name+"','"+gender+"','"+qualification+"','"+specialization+"','"+hospital_name+"','"+email+"','"+password+"','"+street+"','"+area+"','"+city+"','"+state+"');";  
             			
				 st.execute(sql);
				 
				session = request.getSession();
                                session.setAttribute("email",email);
                                session.setAttribute("doctor_id",count);
				session.setAttribute("name",name);
                                response.sendRedirect("doctors_homepage.jsp");

        		}catch(Exception error){}
	
	    	}
	}

%>

                                                                                                                                                                                                                                                                                                                                                                 
</body>
</html>
