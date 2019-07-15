<!DOCTYPE html>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>


<%! 
	Connection con;
	Statement st;
	ResultSet rs;
%>

<%
	
if(request.getMethod().equalsIgnoreCase("POST"))
{
	out.print("in");
	String patientId = (String)session.getAttribute("patient_id");
	String type = request.getParameter("text");
	String ap_no = request.getParameter("ap_no");
	String feedback = request.getParameter("feedback");
	String rating = request.getParameter("rating");
	String review = request.getParameter("review");
	String id = request.getParameter("id");
	String sql;	
	String sql2;
	out.print(type+" "+ap_no+" "+feedback);
	
	int averageReview = ( Integer.parseInt(review) + Integer.parseInt(rating) ) / 2;
	try
	{
		Class.forName("org.postgresql.Driver");
		con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb37","ty37","");
		st = con.createStatement();
		//check this query
		if(type.equals("doctor"))
		{
			sql =" update Doctor_Appointments set feedback ='"+feedback+"' where appointment_no = "+ap_no+" ;";
			sql2 = "update Doctors set review = "+averageReview+" where doctor_id = "+id+";";			
		}
		else
		{
			sql = " update diagnostic_tests set feedback ='"+feedback+"' where test_no = "+ap_no+" ;";
			sql2 = "update diagnostic_labs set review = "+averageReview+" where lab_id = "+id+";";		
		}
		st.execute(sql);
		st.execute(sql2);

		
		response.sendRedirect("patients_homepage.jsp");
		
	}catch(Exception error){
		out.print("Error: "+error);	
	}
}

%>	
