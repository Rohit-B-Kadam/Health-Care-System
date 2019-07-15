<%
	session.removeAttribute("patient_id");
	session.removeAttribute("email");
	session.removeAttribute("name");
	session.invalidate();
	response.sendRedirect("login_page.jsp");

%>
