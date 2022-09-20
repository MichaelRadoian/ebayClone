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
	    String userID = request.getParameter("reset_ID");   
	    String new_pwd = request.getParameter("reset_new_PW");
	    
	    //check for null values in username/password
	    if(userID == null || userID.trim().isEmpty()){
	    	out.println("Invalid Username. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }
	    else if(new_pwd == null || new_pwd.trim().isEmpty()){
	    	out.println("Invalid Password. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("select * from customers where BINARY username='" + userID +"'");
		    if (rs.next()) { //found username, reset password to new_pwd
		    	st = con.createStatement();
		   		st.executeUpdate("update users set password = '" + new_pwd + "' where username = '" + userID + "';");
		   		
		        out.println("Password for " + userID + " successfully reset.<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");   
		    
		    } 
		    else{
		    	out.println("Customer " + userID + " not found.");
		    	out.println("<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");
		    }
	    }
	  
	%>
</body>
</html>