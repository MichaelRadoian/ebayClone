<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	

	 <%
	 	out.println("<a href='userLanding.jsp'> Back to Home.</a><br>");
	 	String username = session.getAttribute("user").toString();
	 	Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Cowtree900");//your local password to MySQL workbench replaces Nine10ofSpades
	    Statement st = con.createStatement();
	    ResultSet result;
	   
	 		try {
    
            //Get the database connection



           
            String str = "SELECT * FROM alert where customerUsername='"+username+"';";
			
        	st = con.createStatement();
    	    result = st.executeQuery(str);
        %>
            
        <!--  Make an HTML table to show the results in: -->
    <table>
        <tr>    
            <td>Auction Id</td>	<td>Type</td>
        </tr>
            <%
            //parse out the results
            while (result.next()) { %>
                <tr>    
                    <td><%= result.getString("auctionId") %></td>   
                    <td><%= result.getString("type") %></td>
                </tr>
                

            <% }
            //close the connection.
            //db.closeConnection(con);
            %>
        </table>

            
        <%} catch (Exception e) {
            out.print(e);
        }
        
	 		
        %>
    

	
</body>
</html>