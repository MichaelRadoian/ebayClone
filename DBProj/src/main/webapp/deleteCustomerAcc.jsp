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
	    String deleteAcc = request.getParameter("delete_Cust_Acc");   
	    
	    //check for null values in username/password
	    if(deleteAcc == null || deleteAcc.trim().isEmpty()){
	    	out.println("Invalid Username. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("select * from customers where BINARY username = '" + deleteAcc +"';");
		    if (rs.next()) { //found username, delete account from users table
		    	st = con.createStatement();
		   		st.executeUpdate("delete from users where username = '" + deleteAcc + "';");
		   		
		        out.println(deleteAcc + " successfully deleted from database.<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");   
		    
		    } 
		    else{
		    	out.println("Username " + deleteAcc + " not found.");
		    	out.println("<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");
		    }
	    }
	  
	%>
</body>
</html>