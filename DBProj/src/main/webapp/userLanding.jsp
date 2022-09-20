<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.sql.Connection,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Panel</title>
</head>
<body>
	<br>Welcome Customer <% out.println(session.getAttribute("user")); %><br>
		<br><br>
		<a href='logout.jsp'>Log out</a>
		<br><br>
		
		<a href='viewAuctions.jsp'>View Auctions</a>
		<br><br>
	
	<a href = 'createAuction.jsp'>Create Auction </a><br><br>
	<a href = 'placeBid.jsp'>Place Bid </a><br><br>
	

		<% try {
	
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String customer_username = session.getAttribute("user").toString();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String unsolvedQueries = "SELECT cs.serviceTicketNumber, cs.customerQuery " + 
									"FROM customerService cs WHERE querySolved = FALSE "
									+ " AND cs.customerUsername = \"" + customer_username + "\";";
			
			String solvedQueries = "SELECT cs.serviceTicketNumber, cs.customerQuery, cs.repResponse, cs.repUsername "
									+ "FROM customerService cs WHERE querySolved = TRUE "
									+ " AND cs.customerUsername = \"" + customer_username + "\";";
			
			
			//Run the query against the database.
			ResultSet unsolvedResult = stmt.executeQuery(unsolvedQueries);
			
			stmt = con.createStatement();
			ResultSet solvedResult = stmt.executeQuery(solvedQueries);
		%>
	
     Ask the Customer Service Team!
    <form action="checkCustomerQuery.jsp" method="POST">
     	Question/Comments: <textarea rows="4" cols="50" name="customer_query"></textarea> <br/>
      <input type="submit" value="Submit"/>
    </form><br/>
	<!--  Make an HTML table to show the results in: -->
	Unsolved Queries:
	<table>
		
		<tr>
			<td>Service Ticket Number</td>    
			<td>Customer Query</td>
			
		</tr>
			<%
			//parse out the results
			while (unsolvedResult.next()) { %>
				<tr>    
					<td><%= unsolvedResult.getString("serviceTicketNumber") %></td> 
					<td><%= unsolvedResult.getString("customerQuery") %></td>
				</tr>
				
			<% }
			//close the connection.
			%>
		</table>
	<br><br>
	Solved Queries
	<table>
		
		<tr> 
			<td>Service Ticket Number</td>  
			<td>Customer Query</td> 
			<td>Response From Customer Service Team</td>
			<td>Response Author</td>
			
		</tr>
			<%
			//parse out the results
			while (solvedResult.next()) { %>
				<tr>   
					<td><%= solvedResult.getString("serviceTicketNumber") %></td> 
					<td><%= solvedResult.getString("customerQuery") %></td>
					<td><%= solvedResult.getString("repResponse") %></td>
					<td><%= solvedResult.getString("repUsername") %></td>
				</tr>
				
			<% }
			//close the connection.
			%>
		</table>

			
		<%
		
		} catch (Exception e) {
			out.print(e);
		}%>
	
	


</body>
</html>