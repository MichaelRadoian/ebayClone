	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.sql.Connection,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>View Auctions</title>
	</head>
	<body>

		<!--  Make an HTML table to show the results in: 
			CHANGE THIS IMPLEMENTATION BASED ON TABLE VALUES\
			
			1. Total Earnings
			2. Earnings Per Item
			3. Earnings Per Item Type
			4. Earnings Per End user
			5. Best Selling Items
			6. Best Buyers -> top five buyers?
			
			SELECT column_name(s)
			FROM table_name
			WHERE condition
			LIMIT number; //limit is used as number of rows returned, ie top 10 would be LIMIT 10
		-->
		<br><br>
		<a href='logout.jsp'>Log out</a>
		<br><br>
		 
		 Use the back button to navigate out of this page.<br><br>
		<% try {
	
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet rs;
			//get category for which we generate a sales report
			String username = session.getAttribute("user").toString();
			/*
			out.println(username);
					
			SR_query_result.getString("total_sales")
					
			String user_level_query = new String();
			
			
			
			user_level_query = "SELECT role "
								+ "FROM users "
								+ "WHERE username = \""
								+ username + "\";";
								
			user_level_query_result = stmt.executeQuery(user_level_query);
			
			user_level_query_result.getString("role");
			*/
			String auction_info = "select auctionId, category, description, brand, color, material, "
								+			"MAX(bidAmount) AS highest_bid, closingDate, closingTime "
								+	"FROM ( "
								+		"select a.auctionId, b.bidAmount, a.minimumPrice, a.closingDate, a.closingTime,  "
								+				"c.category, c.description, c.brand, c.material, c.color "
								+		"from auction a "
								+		"LEFT JOIN bids b  "
								+				"ON a.auctionId = b.auctionId "
								+		"LEFT JOIN auctionItem aItem " 
								+				"ON a.auctionId = aItem.auctionId "
								+		"INNER JOIN clothing c "
								+				"ON c.itemNumber = aItem.itemNumber "
								+		"ORDER BY auctionId ASC, "
								+				"bidAmount DESC,  "
								+				"brand ASC,  "
								+				"description ASC, "
								+				"color ASC "
								+		") as bids_per_auction "
								+	"GROUP BY auctionId;";
			rs = stmt.executeQuery(auction_info);
			
			 %>
		    	<!--  Make an HTML table to show the results in: -->
		    	Auction Information:<br><br>
		    	<table>
		    		<tr>    
		    			<td>Auction ID</td>		
		    			<td>Item Category</td>	
		    			<td>Item Description</td>	
		    			<td>Brand</td>	
		    			<td>Color</td>	
		    			<td>Material</td>	
		    			<td>Highest Current Bid</td>	
		    			<td>Auction Closing Date</td>	
		    			<td>Auction Closing Time</td>	
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (rs.next()) { %>
		    				<tr>    
		    					<td><%= rs.getString("auctionId") %></td>
		    					<td><%= rs.getString("category") %></td>
		    					<td><%= rs.getString("description") %></td>
		    					<td><%= rs.getString("brand") %></td>
		    					<td><%= rs.getString("color") %></td>
		    					<td><%= rs.getString("material") %></td>
		    					<td>$<%= rs.getString("highest_bid") %></td>
		    					<td><%= rs.getString("closingDate") %></td>
		    					<td><%= rs.getString("closingTime") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 	
				
	
		
		} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>