<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative Panel</title>
</head>
	<body>

		Welcome Customer Representative <% out.println(session.getAttribute("user")); %>
		<br><br>
		<a href='logout.jsp'>Log out</a>
		<br><br>
		
		<a href='viewAuctions.jsp'>View Auctions</a>
		<br><br>
		
		Customer Account Services: <br><br>
		Reset Customer Account Password
	     <form action="resetCustomerPW.jsp" method="POST">
	       Customer Username: <input type="text" name="reset_ID"/> <br/>
	       New Password: <input type="text" name="reset_new_PW"/> <br/>
	       <input type="submit" value="Reset Password"/>
	     </form><br/>
	     
	     Delete Customer Account
	     <form action="deleteCustomerAcc.jsp" method="POST">
	      Username: <input type="text" name="delete_Cust_Acc"/> <br/>
	       <input type="submit" value="Delete Account"/>
	     </form><br/>
	    
		<a href='viewCustomerQueries.jsp'>View Customer Questions</a>
		<br/><br/>
	     
		
		Auction Services <br><br>
		Remove Bid
	     <form action="deleteBid.jsp" method="POST">
	     
	       <!--   Auction ID: <input type="text" name="remove_bid_auctionID"/> <br/>>-->
	       Bid ID: <input type="text" name="remove_bid_bidID"/> <br/>
	       <input type="submit" value="Remove Bid"/>
	     </form><br/>
		  
		Delete Auction
	     <form action="deleteAuction.jsp" method="POST">
	       Auction ID: <input type="text" name="remove_auctionID"/> <br/>
	       <input type="submit" value="Remove Auction"/>
	     </form><br/>

		<br>

	</body>
</html>