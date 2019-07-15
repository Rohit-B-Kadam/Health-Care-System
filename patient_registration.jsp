<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>


<html>
<head>
<style>

tr.spaceUnder>td {
  padding-bottom: 15px;
}


</style>
<title> Patient Registration  Page </title>

<script type="text/javascript">

function validationForm()
{
	var dd = document.forms["form1"]["date"].value;
	var mm = document.forms["form1"]["month"].value;
	var yy = document.forms["form1"]["year"].value;	
	
	
	var date = new Date(yy,mm-1,dd);
	
	if( (mm == (date.getMonth() + 1 ) )&& ( yy == ( date.getFullYear() ) )  )
	{
	
	} 
	else
	{
		alert("invalid date");
		return false;	
	}
	
	var name1 = document.forms["form1"]["name"].value;	
	var patt = /^([A-Za-z\ ])+$/;
	if(! patt.test(name1) || ( name1.length > 50))
	{
		alert("Give Proper Name");
		return false;	
	}

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

	var email = document.forms["form1"]["email"].value;
	patt = /^([A-Za-z0-9](\.)?(\-)?)+([A-za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-za-z0-9])+\.([A-za-z0-9]{2,4})$/;	
	
	if(! patt.test(email) || ( email.length > 50))
	{
		alert("email invalid");
		return false;	
	}
	
	var string1 = document.forms["form1"]["password"].value;
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
	
	string1 = document.forms["form1"]["street"].value;
	string2 = document.forms["form1"]["area"].value;
	var string3  = document.forms["form1"]["city"].value;
	var string4 = document.forms["form1"]["state"].value;
	patt = /([A-Za-z])+/;	
	
	if( (!patt.test(string2)) || (!patt.test(string3)) || (!patt.test(string4)) )
	{
		alert("Give Complete Area");
		return false;	
	}
	
	patt = /([0-9])+/;	
	
	if( (patt.test(string2)) || (patt.test(string3)) || (patt.test(string4)) )
	{
		alert("	Area , City and State can not have Number");
		return false;	
	}

	patt = /([0-9A-Za-z])+/;
	
	if(!patt.test(string1))
	{
		alert("Give Proper Street Number");
		return false;		
	}
}

</script>
 
</head>

<body background="Image/222.jpg"  >
<h1><center>&#10012 Patient Registration &#10012</center></h1><br>
<center><h2>Information</h2><br>
<form name="form1" action=# method="POST" autocomplete = "off" onSubmit="return validationForm();">
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
			<%
				for( int i = 1 ; i <= 31 ; i++ )
				{
					out.print("<option value='"+i+"'> "+i+" </option>");
				}
			%>
		</select>


		<select name="month" size="1">
			<%
				for( int i = 1 ; i <= 12 ; i++ )
				{
					out.print("<option value='"+i+"'> "+i+" </option>");
				}
			%>
		</select>


		<select name="year" size="1">
			<%
				for( int i = 1970 ; i <= 2010 ; i++ )
				{
					out.print("<option value='"+i+"'> "+i+" </option>");
				}
			%>
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
		<td><input type="submit" value="Create Account"> <input type="reset"> 
			<a href="login_page.jsp"><input type="button" value="Login"></a>		
		 </td>
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
				rs = st.executeQuery("select * from Patients where email = '"+email+"';");
				if(rs.next())
				{
					%>
						<script> alert("This Email is already exist"); </script>
					<%	
					return;			
				}				
				
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
