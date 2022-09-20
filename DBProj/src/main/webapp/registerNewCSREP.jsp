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
	    String CSREP_ID = request.getParameter("new_CSREP_username");   
	    String CSREP_PW = request.getParameter("new_CSREP_pass");
	    String admin_username = session.getAttribute("user").toString();
		
	    //check for null values in username/password
	    if(CSREP_ID == null || CSREP_ID.trim().isEmpty()){
	    	out.println("Invalid Username. <a href='adminPanel.jsp'>Please Try Again.</a>");
	    }
	    else if(CSREP_PW == null || CSREP_PW.trim().isEmpty()){
	    	out.println("Invalid Password. <a href='adminPanel.jsp'>Please Try Again.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		  	//your local password to MySQL workbench replaces Nine10ofSpades
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("select * from users where username='" + CSREP_ID + "'");
		    if (rs.next()) { //username already exists in database, case insensitive
		        out.println("Username Already Exists, <a href='adminPanel.jsp'>Choose a different Username.</a>");   
		    } 
		    else{
		    	st = con.createStatement();
		    	st.executeUpdate("insert into users (username, password, role) values ('" + CSREP_ID + "', '" + CSREP_PW + "', 'CS_REP');");
		    	
		    	st = con.createStatement();
		    	st.executeUpdate("insert into customerRep (username, password) values ('" + CSREP_ID + "', '" + CSREP_PW + "');");
		    	
		    	st = con.createStatement();
		    	st.executeUpdate("insert into customerRepAccountCreation (repUsername, adminUsername) values ('" 
		    					+ CSREP_ID + "', '" + admin_username + "');");
		    					//admin is the only one who can access this creation page, so session user will always be the admin
		    	
		    	out.println("New Customer Service Account " + CSREP_ID + " registered. <br/>");
		    	out.println("<br/> <a href='adminPanel.jsp'>Return to Administrator Panel.</a><br/>");
		    }
	    }
	     /*=response.sendRedirect("login.jsp");*/ 
	%>
</body>
</html>