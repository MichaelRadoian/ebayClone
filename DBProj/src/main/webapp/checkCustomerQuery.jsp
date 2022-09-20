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
		String query = request.getParameter("customer_query");
		String customer_username = session.getAttribute("user").toString();
		
	    //check for null values in username/password
	    if(query == null || query.trim().isEmpty()){
	    	out.println("Query Cannot be blank. <a href='userLanding.jsp'>Return to Customer Panel</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	st.executeUpdate("INSERT into customerService (customerUsername, customerQuery) values" +  
		    				"(\"" + customer_username + "\", \"" + query + "\"); ");
		    				
	    	out.println("Query Recorded.<a href='userLanding.jsp'>Return to Customer Panel</a>");  
	    					
	    }
	  
	%>
</body>
</html>