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
	    String queryNum = request.getParameter("query_number");
		String queryResponse = request.getParameter("query_response");
	    String responseAuthor = session.getAttribute("user").toString();
	    
	    boolean validQueryNum = true;
	    try{//catches errors if someone tries to put something like Query 'A'
	    	int testForQueryNum = Integer.parseInt(queryNum);
	    }
	    catch(NumberFormatException e){
	    	validQueryNum = false;
	    }
		
	    //check for null values in username/password
	    if(validQueryNum == false || queryNum == null || queryNum.trim().isEmpty() || queryResponse == null || queryResponse.trim().isEmpty()){
	    	out.println("Invalid Query or Query Response. <a href='viewCustomerQueries.jsp'>Return to Customer Queries.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("SELECT * FROM customerService WHERE serviceTicketNumber=" + queryNum 
	    						+ " AND querySolved = FALSE;");
		    if (rs.next()) { //found query, update with response
		    	st = con.createStatement();
		   		st.executeUpdate("update customerService " 
		   						+ "set repResponse = \"" + queryResponse + "\" " 
		   						+ ", querySolved = TRUE, "
		   						+ "repUsername = \"" + responseAuthor + "\" "
		   						+ "where serviceTicketNumber = " + queryNum 
		   						+ ";");
		   		
		        out.println("Response Recorded.<a href='viewCustomerQueries.jsp'>Return to Customer Queries.</a>");   
		    
		    } 
		    else{
		    	out.println("Invalid Query Request. <a href='viewCustomerQueries.jsp'>Return to Customer Queries.</a>");
		    }
	    }
	  
	%>
</body>
</html>