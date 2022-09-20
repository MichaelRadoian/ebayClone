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
	    String auctionID = request.getParameter("remove_auctionID");   
	
	    boolean validAuctionID = true;
	    try{//catches errors if someone tries to put something like Query 'A'
	    	int testForAuctionID = Integer.parseInt(auctionID);
	    }
	    catch(NumberFormatException e){
	    	validAuctionID = false;
	    }
	    //check for null values in username/password
	    if(validAuctionID == false || auctionID == null || auctionID.trim().isEmpty()){
	    	out.println("Invalid Auction ID. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
	    	rs = st.executeQuery("select * from auction where auctionID=" + auctionID +";");
		    if (rs.next()) { //found auction, remove
		    	st = con.createStatement();
		   		st.executeUpdate("delete from auction where auctionID = " + auctionID + ";");
		   		
		        out.println("Auction " + auctionID + " successfully deleted.<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");   
		    
		    } 
		    else{
		    	out.println("Auction " + auctionID + " not found.");
		    	out.println("<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");
		    }
	    }
	  
	%>
</body>
</html>