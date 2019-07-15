<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"  %>
 
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<title> Add Patient Report Page </title> 

<style>

input.buttonColor {
    background-color: #ffa500;
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

div.inner {
	background-color: white;
	width: 600px;
	height: 250px;
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


	var photo = document.forms["form1"]["photo"].value;	
	if(  photo.length == 0)
	{
		alert("Please add report");
		return false;	
	}
		
	return true;
}

</script> 

</head>

<body bgcolor="orange">
<%
	if(session.getAttribute("lab_id")==null)
	{
		response.sendRedirect("login_page.jsp");	
	}
%>

<div class="topnav">
	<form action="lab_logout.jsp" method="GET">
	<table>
		<tr>
			<td style=' width:80em;' ><font size=5 ><a href="lab_technician_homepage.jsp" style="color: white; text-decoration:none;">HEALTH CARE SYSTEM</a></font></td>
			<td style=' width:15em; color:white;'  ><p> <%=session.getAttribute("name")%></p></td>
			<td style=' width:5em;' ><input type="submit" name="submit" value="logout" class="logoutButton button3"></td>
		</tr>
	</table>
	</form>
</div>	
<br>
<br>
<br>
<br>
<br>
<center>
<h1>&#10012Add Patient Report &#10012</h1>
<br>
<br>
<div class='inner'>
<form action=# method="POST" enctype= "multipart/form-data" name="form1" onSubmit="return validationForm();">
<table border-spacing="15" padding=23px >
	<tr class='spaceUnder'>
	  	<th> Patient Email </th>
                <td style=' padding-left: 3em; '><input type="email" name="email" required size="25" autofocus="true"  </td>

	</tr>
		
	<tr class='spaceUnder'  >
                <th>Add Report</th>
                <td style=' padding-left: 3em;'><input type="file" name="photo" required  autofocus="true"  </td>

        </tr>
	<tr  >
		<td></td>
		<td style=' padding-left: 3em;'><input type="submit" name="submit" value="Add Report" class='buttonColor button2'></td>
	</tr>
</table>	
</form>

<!-- JSP -->

<%! 
	Connection con;
	Statement st,st1;
	ResultSet rs,rs1;
%>

<%
	if(request.getMethod().equalsIgnoreCase("POST") )
	//if(request.getParameter("submit").equals("Add Report"))
	{

		InputStream inputStream = null;
		OutputStream outputStream = null;
		try{
			String sql,sql1;
			String labId = (String)session.getAttribute("lab_id");
			String email = request.getParameter("email");
			Part filePart = request.getPart("photo");	
			
			
			if (filePart != null)
			{
				
				
				Class.forName("org.postgresql.Driver");
				con = DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
				st = con.createStatement();
				st1 = con.createStatement();
				sql = "select * from Patients where email = '"+email+"';";
				rs = st.executeQuery(sql);
				if(rs.next())
				{				
					sql1 = "select count(*) from Patient_Reports;";	
					rs1 = st1.executeQuery(sql1);
					rs1.next();
					int count = rs1.getInt(1);
					count++;
					inputStream = filePart.getInputStream();
					String s = filePart.getContentType();
					String filename = count+"."+s.substring(s.lastIndexOf("/")+1);
					String fileUploadPart = application.getInitParameter("fileLocation")+"/"+filename;
					outputStream = new FileOutputStream(fileUploadPart);
					int read = 0;
					byte[] bytes = new byte[1024];
	
					while((read = inputStream.read(bytes)) != -1 )
						outputStream.write(bytes,0,read);
					
					sql1 = "insert into Patient_Reports values ('"+count+"','Report/"+filename+"','"+rs.getString(1)+"');";	
					st1.execute(sql1);

					out.print("File sucessfully uploaded!");

				}
				else
				{
					out.print("<font color='red'>!Invalid email</font>");			
				}
			}
			else
				out.print("null file");

		}catch(Exception error ){
			out.print("Exception" + error);
		}
	}
%>

</div>
</center>
</body>
</html>

