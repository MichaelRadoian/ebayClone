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
	    //String auctionID = request.getParameter("remove_bid_auctionID");   
	 	String bidID = request.getParameter("remove_bid_bidID");  
	 	
	    boolean validBidNum = true;
	    try{//catches errors if someone tries to put something like Query 'A'
	    	int testForBidNum = Integer.parseInt(bidID);
	    }
	    catch(NumberFormatException e){
	    	validBidNum = false;
	    }
	    //check for null values in Auction ID / Bid ID
	    if(validBidNum == false || bidID == null || bidID.trim().isEmpty()){
	    	out.println("Invalid bidID. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }
	    /*
	    else if(auctionID == null || auctionID.trim().isEmpty()){
	    	out.println("Invalid Auction ID. <a href='csRepLanding.jsp'>Please Try Again.</a>");
	    }*/
	    else{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");//your local password to MySQL workbench replaces Nine10ofSpades
		    Statement st = con.createStatement();
		    ResultSet rs;
		    rs = st.executeQuery("select * from bids where bidNumber = " + bidID + ";");
	    	//rs = st.executeQuery("select * from bids where auctionID=" + auctionID +" AND bidNumber = " + bidID + ";");
		    if (rs.next()) { //found auction, remove
		    	st = con.createStatement();
		    
		   		st.executeUpdate("delete from bids b where b.bidNumber = " + bidID + ";");
		
			    out.println("Bid " + bidID + " successfully deleted. " 
			    			+ "<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");   
		    /*
		   		st.executeUpdate("delete from bids b where b.auctionID = " + auctionID 
		   							+ " AND b.bidNumber = " + bidID + ";");
		   		
		        out.println("Bid " + bidID + " from Auction " + auctionID + " successfully deleted. " 
		        			+ "<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");   
		    	*/
		    
		    } 
		    else{
		    	out.println("Bid " + bidID + " not found.");
		    	//out.println("Bid " + bidID + " in Auction " + auctionID + " not found.");
		    	out.println("<a href='csRepLanding.jsp'>Return to CS Rep Panel.</a>");
		    }
	    }
	  
	%>
</body>
</html>