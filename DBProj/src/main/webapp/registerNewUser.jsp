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
	    String new_userID = request.getParameter("new_Username");   
	    String new_pwd = request.getParameter("new_Password");
	    String new_user_role = new String();
	    
	    //check for null values in username/password
	    if(new_userID == null || new_userID.trim().isEmpty()){
	    	out.println("Invalid Username. <a href='login.jsp'>Please Try Again.</a>");
	    }
	    else if(new_pwd == null || new_pwd.trim().isEmpty()){
	    	out.println("Invalid Password. <a href='login.jsp'>Please Try Again.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("select * from users where username='" + new_userID +"'");
		    if (rs.next()) { //username already exists in database, case insensitive
		        out.println("Username Already Exists, <a href='login.jsp'>Choose a different Username.</a>");   
		    } 
		    else{
		    	st = con.createStatement();
		    	st.executeUpdate("insert into users (username, password, role) values (\"" 
		    					+ new_userID + "\", \"" + new_pwd + "\", 'CUSTOMER');");
				
		    	st = con.createStatement();
		    	st.executeUpdate("insert into customers (username, password) values (\""
		    					+ new_userID + "\", \""
		    					+ new_pwd + "\"); ");
		    	
		    	out.println("New User successfully Registered.<br/>");
		    	out.println("<br/>Welcome, " + new_userID);
		    	out.println("<a href='login.jsp'>Please Log In.</a>");
		    }
	    }
	  
	%>
</body>
</html>