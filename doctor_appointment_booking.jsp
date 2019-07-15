<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title> Doctor Appointment  Booking </title> 

<style>
div {
	background-color: white;
	width: 800px;
	border: 1px solid #14BEF0;
	padding-top: 20px;
    	padding-right:2px;
    	padding-bottom:20px;
    	padding-left:2px;

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


tr.spaceUnder>td {
  padding-bottom: 2em;
}

input.button3:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	 background-color: red;
}


</style>
	
<script type="text/javascript">

function validationForm()
{
	var dd = document.forms["form1"]["dd"].value;
	var mm = document.forms["form1"]["MM"].value;
	var yy = document.forms["form1"]["yyyy"].value;	
	
	
	var date = new Date(yy,mm-1,dd);
	
	if( (mm == (date.getMonth() + 1 ) )&& ( yy == ( date.getFullYear() ) )  )
	{
	
	} 
	else
	{
		alert("invalid date");
		return false;	
	}

	var hh = document.forms["form1"]["hh"].value;
	var ampm = document.forms["form1"]["ampm"].value;	

	if( ( (hh >= 1 && hh < 8 ) || hh == 12) && (ampm.localeCompare("am") == 0 ) )
	{
		alert("Give proper Time in range ( 8am to 9pm )");
		return false;	
	}
	else if( ( hh > 9 && hh < 12 ) && (ampm.localeCompare("pm") == 0 ) )
	{
		alert("Give proper Time in range ( 8am to 9pm )");
		return false;	
	}
	
	return true;	
	
}

</script>

</head>

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
			<td style=' width:70em;' ><font size=5 ><a href="patients_homepage.jsp" style="color: white">HEALTH CARE SYSTEM</a></font></td>
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

<h1><center> &#10012 Appointment Booking &#10012</center></h1><br>
<center>
<div>


<%! 
	Connection con;
	Statement st;
	ResultSet rs;
	String id;
	String appointedId;
%>

<%
	if(request.getMethod().equalsIgnoreCase("GET"))
	{
		id = request.getParameter("drID");
		session.setAttribute("appointedId",id);
	}
%>


<%
	appointedId = (String) session.getAttribute("appointedId");
	
	String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		sql = "select * from Doctors where doctor_id = "+appointedId+";";	
			
			rs = st.executeQuery(sql);
			while(rs.next())
			{
				out.print("		<Table>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 1em; '> <font color='#14BEF0' size='5px'>"+rs.getString(2)+" </p> </td>");
				out.print("			<td style='padding-left: 5em; '></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style='padding-left: 3em;' >"+rs.getString(4) +"</td>");
				out.print("			<td></td>");
				out.print("		</tr>");
				out.print("		<tr>");
				out.print("			<td style=' padding-left: 3em; width:400px;' >"+rs.getString(9)+" "+rs.getString(10)+" "+rs.getString(11)+" "+rs.getString(12)+"</td>");
				out.print("		</tr>");

				out.print("		</table>");
			}	
	}catch(Exception error)
	{
		out.print("Exxception "+error);	
	}




%>


</div>
<div>
<center><h2>Book An Appointment</h2><br>
<form action=# method="POST" name="form1" onSubmit="return validationForm();">
<table border-spacing="15" padding=23px >


<tr>
		<td> Date: </td>
		<td style='padding-left: 2em;' >
			<select name="dd" size="1">
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


		<select name="MM" size="1">
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


		<select name="yyyy" size="1">
			<option value="2018"> 2018 </option>
			<!--<option value="2019"> 2019 </option>
			<option value="2020"> 2020 </option>-->
		</select>
	</td>
	</tr>

	<tr class="spaceUnder">
                <td> Time: </td>

    		<td style='padding-left: 2em;' > 
		           <select name="hh" size="1">
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
                        <option value="11"> 11 </option>
			 <option value="12"> 12 </option>
                </select>


 		<select name="mm" size="1">
                        <option value="0"> 00 </option>
                        <option value="15"> 15 </option>
                        <option value="30"> 30 </option>
                        <option value="45"> 45 </option>
 
		</select>
		
		<select name="ampm" size="1">
                        <option value="am"> am </option>
                        <option value="pm"> pm </option>
 
		</select>
            

</td>
<tr >
<td></td>
<td style="padding-left: 2em;" > <button type="submit" > Book </button><td>
</tr>
</form>

<%

if(request.getMethod().equalsIgnoreCase("POST"))
{
	String dd = request.getParameter("dd");
	String MM = request.getParameter("MM");
	String yyyy = request.getParameter("yyyy");
	String hh = request.getParameter("hh");
	String mm = request.getParameter("mm");
	String ampm = request.getParameter("ampm");	
	
	String date = MM+"/"+dd+"/"+yyyy;
	String time = hh+":"+mm+":00 "+ampm+"";

	String patientId = (String)session.getAttribute("patient_id");
	appointedId = (String) session.getAttribute("appointedId");
	
	//String sql;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		sql = "select count(*) from Doctor_Appointments;";	
		rs = st.executeQuery(sql);
		rs.next();
		int count = Integer.parseInt(rs.getString(1));
		count++;
		sql = "select * from Doctor_Appointments where appointment_date = '"+date+"' and  appointment_time = '"+time+"' and doctor_id = '"+appointedId+"';";
	
		rs = st.executeQuery(sql);
		
		if(rs.next())
		{
			out.print("time is already book");
		}		
		else
		{
			sql = "insert into Doctor_Appointments values( '"+count+"','"+date+"','"+time+"','','"+patientId+"','"+appointedId+"');";			
			st.execute(sql);
			out.print("successfully add");
		}
	}catch(Exception error)
	{
		out.print("Exxception "+error);	
	}	
}



%>

</div>
</center>
</center>

</body>
</html>
