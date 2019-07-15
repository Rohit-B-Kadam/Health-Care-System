<%
	session.removeAttribute("doctor_id");
	session.removeAttribute("email");
	session.removeAttribute("name");
	session.invalidate();
	response.sendRedirect("login_page.jsp");

%>
