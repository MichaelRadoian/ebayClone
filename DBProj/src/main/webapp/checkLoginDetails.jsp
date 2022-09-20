<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<%@ page import ="java.sql.*" %>
	<%
	    String userid = request.getParameter("username");   
	    String pwd = request.getParameter("password");
	    
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("select * from users where BINARY username='" + userid + "' and BINARY password='" + pwd + "'");
	    /*
	    	BINARY keyword allows comparison of character binary value, which makes username and password case sensitive.
	    	In the code from sakai, both of these are case insensitive.
		*/
		
		// Redirects logged in User based on user_role, implement your functionality for admin/CS_Rep/customer 
		//on the jsp page you are redirected to.
		
	    if (rs.next()) {
		    String user_role = rs.getString("role");
		    
		 	// the username will be stored in the session
		    session.setAttribute("user", userid);
		    
		    switch(user_role){
			    case "ADMIN":
			    	//redirect to adminLanding page
			    	response.sendRedirect("adminPanel.jsp");
			    	break;
			    case "CS_REP":
			    	//redirect to CS Rep landing page
			    	response.sendRedirect("csRepLanding.jsp");
			    	break;
			    default:
			    	//redirect to end user/customer landing page
			    	response.sendRedirect("userLanding.jsp");
		    }
	       
	    } else {
	        out.println("Invalid Credentials <a href='login.jsp'>Please Try Again</a>");
	    }
	%>
</body>
</html>