<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%!
        Statement st;
        ResultSet rs;
        Connection con;
 %>
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
	var name1 = document.forms["form1"]["name"].value;	
	var patt = /^([A-Za-z\ ])+$/;
	if( (!patt.test(name1)) || ( name1.length > 50))
	{
		alert("Give Proper Name");
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

}

</script>

<title> Lab Technician Page </title> 
</head>

<body background="Image/332.jpeg" >
<h1><center>Lab Technician Registration &#10012</center></h1><br>
<center><h2>Information</h2><br>
<form name="form1" action=# method="POST" autocomplete = "off" onSubmit="return validationForm();">
<table border-spacing="15" padding=23px >
	<tr class="spaceUnder">
		<td> Lab Name </td>
		<td><input type="text" name="name" required size="20" autofocus="true"  placeholder="Lab Name"> </td>
	</tr>
 	<tr class="spaceUnder">
 		<td>Test Provider</td>
	         <td>   <select name="test_provider" size="5" multiple>
<%
			try
			{
				Class.forName("org.postgresql.Driver");
      	      	  		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
      	          		st=con.createStatement();
				rs=st.executeQuery("select * from Tests;");
				int i = 1;
				while( rs.next() )
				{
			%>	
					 <option value="<%= rs.getString(1) %>"> <%=rs.getString(2) %> </option>
			<%
				}
			}catch(Exception error){
				out.print("Exception: in select tag");			
			}
%>
					
			</select>
		 </td>
	</tr>
	

	
	<tr class="spaceUnder">
		<td>Email</td>
                <td><input type="email" name="email" required size="25" autofocus="true" placeholder="Enter Your Email"></td>
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
		 <td> street<input name="street" type="text" size=5> area <input  name="area" type="text" size="5"> city <input name="city" type="text" size="5"> state <input name="state" type="text" size="5"></td>
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

<!- JSP -->





<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmPassword");
	String street = request.getParameter("street");
	String area = request.getParameter("area");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String[] testProvider = request.getParameterValues("test_provider");
	String sql;
	
	int count=0;
	int countTest = 0;
	if( request.getMethod().equalsIgnoreCase("POST"))
	{
		if( name.isEmpty()  || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || street.isEmpty() || area.isEmpty() || city.isEmpty() || state.isEmpty()  )	
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
				
				rs = st.executeQuery("select * from Diagnostic_labs where email = '"+email+"';");
				if(rs.next())
				{
					%>
						<script> alert("This Email is already exist"); </script>
					<%	
					return;			
				}	
			
      	          		rs=st.executeQuery("select * from diagnostic_labs;");
      	          		while(rs.next())
      	          		{
                       			count++;
      	          		}
				count ++;
	
				sql = "insert into Diagnostic_labs values("+count+",'"+name+"','"+email+"','"+password+"','"+street+"','"+area+"','"+city+"','"+state+"');";  
              			st.execute(sql);
				
				rs=st.executeQuery("select * from Test_Provider;");
                                while(rs.next())
                                {
                                        countTest++;
                                }
                                countTest ++;

				
				if(testProvider != null)
				{
					for(String t : testProvider)
					{
						sql = "insert into Test_Provider values('"+countTest+"','"+t+"','"+count+"');";
						st.execute(sql);
						countTest++;
					}			
				}
				
				 session = request.getSession();
                                session.setAttribute("email",email);
                                session.setAttribute("lab_id",count);
				session.setAttribute("lab_id",count);
                                response.sendRedirect("lab_technician_homepage.jsp");

		
        		}catch(Exception error){}
	
	    	}
	}

%>


</body>
</html>
