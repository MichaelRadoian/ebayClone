<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.sql.Connection,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Questions</title>
	</head>
	<body>
	
	

		<% try {
	
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Nine10ofSpades");	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String unsolvedQueries = "SELECT cs.serviceTicketNumber, cs.customerUsername, cs.customerQuery " + 
									"FROM customerService cs WHERE querySolved = FALSE;";
			
			String solvedQueries = "SELECT * FROM customerService WHERE querySolved = TRUE;";
			
			
			//Run the query against the database.
			ResultSet unsolvedResult = stmt.executeQuery(unsolvedQueries);
			
			stmt = con.createStatement();
			ResultSet solvedResult = stmt.executeQuery(solvedQueries);
		%>
			
	<a href='csRepLanding.jsp'>Customer Service Main Page</a>
	<br><br>
	
     Respond to Customer Query (Responses cannot be changed once submitted)
    <form action="checkQueryResponse.jsp" method="POST">
     	Query Number: <input type="text" name="query_number"/> <br/>
     	Response: <textarea rows="4" cols="50" name="query_response"></textarea> <br/>
      <input type="submit" value="Respond"/>
    </form><br/>
	<!--  Make an HTML table to show the results in: -->
	Unsolved Queries:
	<table>
		
		<tr>    
			<td>Query Number</td>
			<td>Customer Username</td>
			<td>Customer Query</td>
			
		</tr>
			<%
			//parse out the results
			while (unsolvedResult.next()) { %>
				<tr>    
					<td><%= unsolvedResult.getString("serviceTicketNumber") %></td>
					<td><%= unsolvedResult.getString("customerUsername") %></td>
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
			<td>Query Number</td>
			<td>Customer Username</td>
			<td>CS Rep Response Author</td>
			<td>Customer Query</td>
			<td>Response From Customer Service Team</td>
			
		</tr>
			<%
			//parse out the results
			while (solvedResult.next()) { %>
				<tr>    
					<td><%= solvedResult.getString("serviceTicketNumber") %></td>
					<td><%= solvedResult.getString("customerUsername") %></td>
					<td><%= solvedResult.getString("repUsername") %></td>
					<td><%= solvedResult.getString("customerQuery") %></td>
					<td><%= solvedResult.getString("repResponse") %></td>
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