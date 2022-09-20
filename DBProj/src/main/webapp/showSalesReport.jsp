	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.sql.Connection,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report</title>
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
		<a href='adminPanel.jsp'>Administrator Panel</a>
		<br><br>
		 
		<% try {
	
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//get category for which we generate a sales report
			String entity = request.getParameter("SR_Category");
			String SR_query = new String();
			ResultSet SR_query_result;
			
					
			//create sql statement here depending on category
			switch(entity){
			    case "Total_Earnings"://total spent across all customer accounts - change to use closed auction info?
			    	SR_query = "select round(sum(highest_bid), 2) AS total_sales "
				    			+ "FROM(" 
				    			+ "	select auctionId, MAX(bidAmount) AS highest_bid, minimumPrice, "
				    			+    		" closingDate, closingTime, description, brand, color, material "
				    			+		"FROM ("
				    			+			"select a.auctionId, b.bidAmount, a.minimumPrice, a.closingDate, a.closingTime, "
				    			+					"c.description, c.brand, c.material, c.color "
				    			+			"from auction a "
				    			+			"LEFT JOIN bids b "
				    			+					" ON a.auctionId = b.auctionId "
				    			+			"LEFT JOIN auctionItem aItem "
				    			+					"ON a.auctionId = aItem.auctionId "
				    			+			"INNER JOIN clothing c "
				    			+					"ON c.itemNumber = aItem.itemNumber "
				    			+			"ORDER BY auctionId ASC, "
				    			+					"bidAmount DESC, "
				    			+					"brand ASC, "
				    			+					"description ASC, "
				    			+                	"color ASC "
				    			+			") as bids_per_auction "
				    			+		"GROUP BY auctionId "
				    			+	") as max_bids_per_auction "
				    			+ "WHERE (closingDate <= CURRENT_DATE "
				    			+	"OR (closingDate = CURRENT_DATE AND closingTime < CURRENT_TIME)) "
				    			+   "AND highest_bid >= minimumPrice"
				    			+ ";"
			    		;
			    	break;
			    	
			    case "EP_Item": 
			    	//earnings per item (highest winning bid per auction), sorted by item type 
			    	//GROUP BY itemType, ORDER BY winning bid amount from auction DESC
			    	
			    	SR_query = "select round(highest_bid, 2) AS final_sale_price, auctionId, description, brand, color, material "
				    			+ "FROM(" 
				    			+ "	select auctionId, MAX(bidAmount) AS highest_bid, minimumPrice, "
				    			+    		" closingDate, closingTime, description, brand, color, material "
				    			+		"FROM ("
				    			+			"select a.auctionId, b.bidAmount, a.minimumPrice, a.closingDate, a.closingTime, "
				    			+					"c.description, c.brand, c.material, c.color "
				    			+			"from auction a "
				    			+			"LEFT JOIN bids b "
				    			+					" ON a.auctionId = b.auctionId "
				    			+			"LEFT JOIN auctionItem aItem "
				    			+					"ON a.auctionId = aItem.auctionId "
				    			+			"INNER JOIN clothing c "
				    			+					"ON c.itemNumber = aItem.itemNumber "
				    			+			"ORDER BY auctionId ASC, "
				    			+					"bidAmount DESC, "
				    			+					"brand ASC, "
				    			+					"description ASC, "
				    			+                	"color ASC "
				    			+			") as bids_per_auction "
				    			+		"GROUP BY auctionId "
				    			+	") as max_bids_per_auction "
				    			+ "WHERE (closingDate <= CURRENT_DATE "
				    			+	"OR (closingDate = CURRENT_DATE AND closingTime < CURRENT_TIME)) "
				    			+   "AND highest_bid >= minimumPrice"
				    			+ ";"
				    		;
			    	
			    	break;
			    	
			    case "EP_Item_Type": 
			    	//aggregate of earnings per item, shows earnings per category. 
			    	//GROUP BY itemType, use sum() and round()
			    	
			    	SR_query = "select category, round(sum(highest_bid), 2) AS category_sum"
							+"	from( "
							+		"select auctionId, MAX(bidAmount) AS highest_bid, minimumPrice, "
							+						"closingDate, closingTime, category, description, brand, color, material "
							+				"FROM ( "
							+					"select a.auctionId, b.bidAmount, a.minimumPrice, a.closingDate, a.closingTime, " 
							+							"c.category, c.description, c.brand, c.material, c.color "
							+					"from auction a "
							+					"LEFT JOIN bids b "
							+							"ON a.auctionId = b.auctionId "
							+					"LEFT JOIN auctionItem aItem "
							+							"ON a.auctionId = aItem.auctionId "
							+					"INNER JOIN clothing c "
							+							"ON c.itemNumber = aItem.itemNumber "
							+					"ORDER BY auctionId ASC, "
							+							"bidAmount DESC, "
							+							"brand ASC, "
							+							"description ASC, "
							+							"color ASC "
							+					") as bids_per_auction "
							+				"GROUP BY auctionId ) as closed_auction_info "
							+	"WHERE (closingDate <= CURRENT_DATE "
							+		"OR (closingDate = CURRENT_DATE AND closingTime < CURRENT_TIME)) "
							+	    "AND highest_bid >= minimumPrice "
							+	"GROUP BY category;";
			    	
			    	
			    	break;
			    	
			    case "EP_End_User": 
			    	//shows list of amountSpent per customer account, 
			    	//ORDER BY amountSpent DESC

					SR_query = "select username, round(amountSpent, 2) AS rounded_total "
								+ "from customers "
								+ "ORDER BY username ASC;";
			    	break;
			    	
			    case "Best_Selling_Items":
			    	//Count number of items per category sold (closed auctions)
			    	
			    	String SR_update = new String();
			    	SR_update = "DROP TEMPORARY TABLE IF EXISTS items_sold_per_category; ";
			    	stmt.executeUpdate(SR_update);
			    	
			    	SR_update =	"CREATE TEMPORARY TABLE items_sold_per_category AS ( "
								+		"select category, count(category) AS sold_per_category "
								+"	from( "
								+		"select auctionId, MAX(bidAmount) AS highest_bid, minimumPrice, "
								+						"closingDate, closingTime, category, description, brand, color, material "
								+				"FROM ( "
								+					"select a.auctionId, b.bidAmount, a.minimumPrice, a.closingDate, a.closingTime, " 
								+							"c.category, c.description, c.brand, c.material, c.color "
								+					"from auction a "
								+					"LEFT JOIN bids b "
								+							"ON a.auctionId = b.auctionId "
								+					"LEFT JOIN auctionItem aItem "
								+							"ON a.auctionId = aItem.auctionId "
								+					"INNER JOIN clothing c "
								+							"ON c.itemNumber = aItem.itemNumber "
								+					"ORDER BY auctionId ASC, "
								+							"bidAmount DESC, "
								+							"brand ASC, "
								+							"description ASC, "
								+							"color ASC "
								+						") as bids_per_auction "
								+					"GROUP BY auctionId ) as closed_auction_info "
								+		"WHERE (closingDate <= CURRENT_DATE "
								+			"OR (closingDate = CURRENT_DATE AND closingTime < CURRENT_TIME)) "
								+			"AND highest_bid >= minimumPrice "
								+		"GROUP BY category "
								+		"ORDER BY sold_per_category DESC "
								+	"); ";
					stmt = con.createStatement();
					stmt.executeUpdate(SR_update);				
								
								
					SR_update =	"DROP TEMPORARY TABLE IF EXISTS ISPC2; ";
					
					stmt = con.createStatement();
					stmt.executeUpdate(SR_update);						
					
					SR_update =	"CREATE TEMPORARY TABLE ISPC2 AS ( "
								+	"select * from items_sold_per_category);";
					stmt = con.createStatement();
					stmt.executeUpdate(SR_update);	
							
					SR_query = 	"SELECT * from items_sold_per_category ISPC "
							+	"WHERE ISPC.sold_per_category = (SELECT max(sold_per_category) FROM ISPC2);";
			    	
			    	break;
			    	
			    case "Best_Buyers":
			    	//find customer with highest amountSpent
			    	//top ten customers with highest amount spent.
			    	
					SR_query = "select username, round(amountSpent, 2) AS rounded_total "
								+ "from customers "
								+ "ORDER BY amountSpent DESC "
		    					+ "LIMIT 3;";
		    		
			    	break;
			}
			
			
			//Run the query against the database.
			stmt = con.createStatement();
			SR_query_result = stmt.executeQuery(SR_query);
			
			
			
			//make tables here
			switch(entity){
		    case "Total_Earnings"://total spent across all customer accounts
		    %>
		    	<!--  Make an HTML table to show the results in: -->
		    	Total Earnings Report (Total sales across all closed auctions):<br><br>
		    	<table>
		    		<tr>    
		    			<td>Total Earnings</td>		
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td>$<%= SR_query_result.getString("total_sales") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 	
		    	break;
		    	
		    case "EP_Item": 
		    	//earnings per item (highest winning bid per auction), sorted by item type 
		    	//GROUP BY itemType, ORDER BY winning bid amount from auction DESC
		    	%>
		    	Earnings Per Item Report (Final Sale Price per Closed Auction):<br><br>
		    	<table>
		    		<tr>    
		    			<td>Final Sale Price</td>	
		    			<td>Auction ID</td>	
		    			<td>Item Description</td>	
		    			<td>Item Brand</td>	
		    			<td>Item Color</td>	
		    			<td>Item Material</td>		
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td>$<%= SR_query_result.getString("final_sale_price") %></td>
		    					<td><%= SR_query_result.getString("auctionId") %></td>
		    					<td><%= SR_query_result.getString("description") %></td>
		    					<td><%= SR_query_result.getString("brand") %></td>
		    					<td><%= SR_query_result.getString("color") %></td>
		    					<td><%= SR_query_result.getString("material") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 
		    	break;
		    	
		    case "EP_Item_Type": 
		    	//aggregate of earnings per item, shows earnings per category. 
		    	//GROUP BY itemType, use sum() and round()
		    	%>
		    	Earnings Per Item Type (Total per Category based on closed auctions):<br><br>
		    	<table>
		    		<tr>    
		    			<td>Category</td>	
		    			<td>Earnings Per Category</td>	
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td><%= SR_query_result.getString("category") %></td>
		    					<td>$<%= SR_query_result.getString("category_sum") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 
		    	break;
		    	
		    case "EP_End_User": 
		    	//shows list of amountSpent per customer account, 
		    	//ORDER BY amountSpent DESC
		    	%>
		    	Earnings Per End User:<br><br>
		    	<table>
		    		<tr>    
		    			<td>Customer Username</td>	
		    			<td>Total amount spent on winning bids</td>	
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td><%= SR_query_result.getString("username") %></td>
		    					<td>$<%= SR_query_result.getString("rounded_total") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 
		    	break;
		    	
		    case "Best_Selling_Items":
		    	//Count number of items per category sold (closed auctions)
		    	
		    	%>
		    	Top Selling Categories:<br><br>
		    	<table>
		    		<tr>    
		    			<td>Category</td>	
		    			<td>Number of Sold Items (closed auctions)</td>	
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td><%= SR_query_result.getString("category") %></td>
		    					<td><%= SR_query_result.getString("sold_per_category") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 
		    	break;
		    	
		    case "Best_Buyers":
		    	//find customer with highest amountSpent
		    	%>
		    	Best Buyers (Top Three Users):<br><br>
		    	<table>
		    		<tr>    
		    			<td>Customer Username</td>	
		    			<td>Total amount spent on winning bids</td>	
		    		</tr>
		    			<%
		    			//parse out the results
		    			while (SR_query_result.next()) { %>
		    				<tr>    
		    					<td><%= SR_query_result.getString("username") %></td>
		    					<td>$<%= SR_query_result.getString("rounded_total") %></td>
		    				</tr>
		    			<% }
		    			//close the connection.
		    			%>
		    		</table>
		    	<br><br>
		    	<% 
		    	break;
		}
		
		} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>