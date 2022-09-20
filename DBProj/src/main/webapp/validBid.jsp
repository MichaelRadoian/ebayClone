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
		String automatic = request.getParameter("automatic");
		int bidAmount;
		int auctionId;
		int bidLimit=0;
		int bidNumber;
		double highestBid=0;
		double increment=0;
		double minBid=0;
		String username = session.getAttribute("user").toString();
		out.println(username);
		if(request.getParameter("auctionId").trim().isEmpty() || request.getParameter("bidAmount").trim().isEmpty()){
			out.println("please fill out all entries . <a href='placeBid.jsp'> Please Try Again.</a>");
			return;
			
		}
		
		bidAmount = Integer.parseInt(request.getParameter("bidAmount"));
		auctionId= Integer.parseInt(request.getParameter("auctionId"));
		bidNumber = bidAmount +auctionId;
		if(automatic != null){
			if(request.getParameter("bidLimit").trim().isEmpty() || request.getParameter("increment").trim().isEmpty()){
				out.println("please fill out all entries . <a href='placeBid.jsp'> Please Try Again.</a>");
				return;
			}
			bidLimit = Integer.parseInt(request.getParameter("bidLimit"));
			increment = Double.parseDouble(request.getParameter("increment"));
		}
		
		
		Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Cowtree900");//your local password to MySQL workbench replaces Nine10ofSpades
	    Statement st = con.createStatement();
		st = con.createStatement();
		
		ResultSet rs = st.executeQuery("select auctionId from auction where auctionId ='"+auctionId+"';");
		if(!rs.next()){
			out.println("Not a Valid Auction . <a href='placeBid.jsp'> Please Try Again.</a>");
			return;
		}
		
		rs = st.executeQuery("select username from users where BINARY username='" + username + "'; ");
		if(!rs.next()){
			out.println("Not Correct Username . <a href='placeBid.jsp'> Please Try Again.</a>");
			return;
		}
		
		if(automatic != null){
			st.executeUpdate("insert into bids (username, auctionId, bidAmount,bidNumber,bidLimit,increment,typeOfBid) values ('" +username+"','"+auctionId+"','"+bidAmount+"','"+bidNumber+"','"+bidLimit+"','"+increment+"','automatic');");
		}
		else{
			st.executeUpdate("insert into bids (username, auctionId, bidAmount,bidNumber,typeOfBid) values ('" +username+"','"+auctionId+"','"+bidAmount+"','"+bidNumber+"','manual');"); // complete later
		}
		
		
		rs = st.executeQuery("select * from alert where customerUsername='"+username+"' and auctionId = '"+auctionId+"';");
		if(!rs.next()){
			st.executeUpdate("insert into alert (auctionId, customerUsername,type) values ('"+auctionId+"','"+username+"','none');");
		}
		
		
		rs = st.executeQuery("select max(bidAmount) from bids where username <> '"+username+"';");
		if(rs.next()){
			highestBid = rs.getDouble("max(bidAmount)");
			rs=st.executeQuery("select minimumPrice from auction where auctionId = '"+auctionId+"';");
			if(rs.next()){
				minBid=rs.getDouble("minimumPrice");
				if(bidAmount > highestBid ){
					st.executeUpdate("update alert set type = 'higher bid' where customerUsername<>'"+username+"' and auctionId = '"+auctionId+"';");
					if(minBid<bidAmount){
					st.executeUpdate("update alert set type = 'winner' where customerUsername='"+username+"' and auctionId = '"+auctionId+"';");
					}
				}
			}
		}
		
		
		
		
		
		
		
		
		out.println("Bid Posted <a href='userLanding.jsp'> Back to Home.</a>");
	%>
</body>
</html>