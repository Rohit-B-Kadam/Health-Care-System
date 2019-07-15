<html>
<head>
<title> Ask Question </title>

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

div {
	background-color: white;
	width: 800px;
	height: 400px;
	border: 1px solid #ffffff;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;
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
	width: 98%;
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
	var title = document.forms["form1"]["title"].value;	
	if( title.length == 0)
	{
		alert("Give Proper Title");
		return false;
	}
	
	var description = document.forms["form1"]["description"].value;	
	if( description.length < 15)
	{
		alert("Describe your problem properly");
		return false;
	}
		
	return true;
}

</script> 

</head>

<!--<body bgcolor=#28328C > -->
<body bgcolor=#14BEF0>
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
			<td style=' width:10em; color:white'  ><%=session.getAttribute("name")%></td>
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton button3"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>	
<font color="white"><center><h1>&#10012 Ask Question &#10012</h1></center></font>
<center>
<div>
<h2>Explain your Health Problem</h2><br>
<form action=# method="POST" name="form1" onSubmit="return validationForm();">
<table border-spacing="15" padding=23px >

         <tr class="spaceUnder" >
		<td>Problem Type</td>
                <td style=" padding-left: 3em;">
			<select name="problem_type" required size="1" autofocus="true" >
<%
			try
			{
				Class.forName("org.postgresql.Driver");
      	      	  		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
      	          		st=con.createStatement();
				rs=st.executeQuery("select DISTINCT(specialization) from Doctors U;");
				int i = 1;
				while( rs.next() )
				{
			%>	
					 <option value="<%= rs.getString(1) %>"> <%=rs.getString(1) %> </option>
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
                <td>Title</td>
                <td  style=" padding-left: 3em;"><input name="title" type="text"  required size="25" autofocus="true" placeholder="Explain your problem "></td>
        </tr>

      <tr class="spaceUnder">
                <td>Description</td>
                <td  style=" padding-left: 3em;"><textarea name="description" style="width: 22em; height: 10em; "  placeholder="Explain your problem in detail "></textarea></td>
        </tr>
<tr>
<td></td>
<td  style=" padding-left: 3em;"><input type="submit"  value="Send" class="buttonColor button2"> </td>
</tr>
</table>
</form>

<!-- JSP -->

<%@ page import="java.sql.*" %>

<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%

if(request.getMethod().equalsIgnoreCase("POST"))
{
	String problemType = request.getParameter("problem_type");
	String title = request.getParameter("title");
	String description = request.getParameter("description");
	String sql;
	if( title.isEmpty() )
	{
		out.print("<font color='red'>!fill complete detail</font>");
	}
	else
	{
		try
		{
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
			st = con.createStatement();
			
			String patientId = (String)session.getAttribute("patient_id");
			
					
			
			sql = "select count(*) from Consults;";
			
	
			rs = st.executeQuery(sql);
			rs.next();
			int count = Integer.parseInt(rs.getString("count"));
			count++;
			
			sql = "insert into Consults values( '"+count+"','"+problemType+"','"+title+"','"+description+"','"+patientId+"');";
						
			st.execute(sql);
			out.print("successfully add");

		}catch(Exception error)
		{
			out.print("Exception"+error);
		}
	}
}
%>
</div>
</body>
</html>
