<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator Panel</title>
</head>
	<body>

		Welcome Administrator <% out.println(session.getAttribute("user")); %>
		
		<br><br>
		<a href='logout.jsp'>Log out</a>
		<br><br>
		
		<a href='viewAuctions.jsp'>View Auctions</a>
		<br><br>
		
		Sales Report Categories: <br>
		<form  action="showSalesReport.jsp" method="post">
		  <input type="radio" name="SR_Category" value="Total_Earnings"/>Total Earnings
		  <br>
		  
		  <input type="radio" name="SR_Category" value="EP_Item"/>Earnings Per: Item
		  <br>
		  
		  <input type="radio" name="SR_Category" value="EP_Item_Type"/>Earnings Per: Item Type
		  <br>
		  
		  <input type="radio" name="SR_Category" value="EP_End_User"/>Earnings Per: End-User/Customer
		  <br>
		  
		  <input type="radio" name="SR_Category" value="Best_Selling_Items"/>Best Selling Items
		  <br>
		  
		  <input type="radio" name="SR_Category" value="Best_Buyers"/>Best Buyers
		  <br>	

		  <input type="submit" value="Generate Sales Report" />
		</form>
		<br>
		
		
		Customer Service Representative Account Creation
	     <form action="registerNewCSREP.jsp" method="POST">
	       Username: <input type="text" name="new_CSREP_username"/> <br/>
	       Password:<input type="password" name="new_CSREP_pass"/> <br/>
	       <input type="submit" value="Register"/>
	     </form>
	     <br> <br>
	</body>
</html>