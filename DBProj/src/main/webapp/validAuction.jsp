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
 	String color = request.getParameter("itemColor");
 	String brand = request.getParameter("itemBrand");
 	String material = request.getParameter("itemMaterial");
 	String description = request.getParameter("itemDescription");
 	String closingDate = request.getParameter("closingDate");
 	String closingTime = request.getParameter("closingTime");
 	String type = request.getParameter("type");
 	double minimumBid = -1;
 	double neckWidth=-1;
 	double sleeveLength=-1;
 	double shoulderWidth=-1;
 	double inseamLength=-1;
 	double waistSize=-1;
 	double footWidth=-1;
 	double footSize=-1;
 	int itemNumber=0;
 	int auctionId=0;
 	
 	if(color == null || color.trim().isEmpty() || brand == null || material == null || description == null || closingDate == null || closingTime == null || request.getParameter("minimumBid") == null 
 			|| brand.trim().isEmpty() || material.trim().isEmpty() || description.trim().isEmpty() || closingDate.trim().isEmpty() || closingTime.trim().isEmpty() || request.getParameter("minimumBid").trim().isEmpty()){
 		out.println("please fill out all entries . <a href='createAuction.jsp'> Please Try Again.</a>");
 		return;
 	}
 	 	
 	if(type == null){
 		out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
 		return;
 	}
  
	
 	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buyme_db","root", "Cowtree900");//your local password to MySQL workbench replaces Nine10ofSpades
    Statement st = con.createStatement();
	st = con.createStatement();
	st.executeUpdate("insert into clothing (category, description, material, brand, color) values ('"+type+"','" + description + "','"+material+"','"+brand+"','"+color+"');");
	ResultSet rs = st.executeQuery("select itemNumber from clothing where color='" + color +"' and brand='"+ brand +"' and material='"+material+"' and description ='"+description+"';");
	
	
	
	
	if(rs.next()){
		itemNumber = rs.getInt("itemNumber");
	}
	
	
 	
	
	
	if(type.equals("Top")){
 		if(request.getParameter("neckWidth").trim().isEmpty()  || request.getParameter("sleeveLength").trim().isEmpty() || request.getParameter("shoulderWidth").trim().isEmpty()){
			out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
			return;
 		}
 		neckWidth = Double.parseDouble(request.getParameter("neckWidth"));
 	 	sleeveLength = Double.parseDouble(request.getParameter("sleeveLength"));
 	 	shoulderWidth =  Double.parseDouble(request.getParameter("shoulderWidth"));

 		st.executeUpdate("insert into top(itemNumber, neckWidth, sleeveLength, shoulderWidth) values ('"+itemNumber+"','"+neckWidth+"','"+sleeveLength+"','"+shoulderWidth+"');");
 	}
 	
 	
 	
 	
 	else if(type.equals("Bottom")){
 		if(request.getParameter("inseamLength").trim().isEmpty()  || request.getParameter("waistSize").trim().isEmpty()){
			out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
			return;
 		}
 		inseamLength =  Double.parseDouble(request.getParameter("inseamLength"));
 	 	waistSize =  Double.parseDouble(request.getParameter("waistSize"));
 		if(inseamLength<1 || waistSize<1){
 			out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
 		}
 		st.executeUpdate("insert into bottom (itemNumber, inseamLength, waistSize) values ('"+itemNumber+"','"+inseamLength+"','"+waistSize+"');");
 	}
 	
 	
 	
 	
 	
 	else{
 		if(request.getParameter("footWidth").trim().isEmpty()  || request.getParameter("footSize").trim().isEmpty()){
			out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
			return;
 		}
 		footWidth =  Double.parseDouble(request.getParameter("footWidth"));
 	 	footSize =  Double.parseDouble(request.getParameter("footSize"));
 		if(footWidth<1 || footSize<1){
 			out.println("please fill out all entries. <a href='createAuction.jsp'> Please Try Again.</a>");
 		}
 		st.executeUpdate("insert into footwear (itemNumber, size,width ) values ('"+itemNumber+"','"+footSize+"','"+footWidth+"');");
 	}
	minimumBid =  Double.parseDouble(request.getParameter("minimumBid"));
	st.executeUpdate("insert into auction(closingDate,closingTime,minimumPrice) values ('"+closingDate+"','"+closingTime+"','"+minimumBid+"');");
	rs = st.executeQuery("select auctionId from auction where closingDate='" + closingDate +"' and closingTime='"+ closingTime +"' and minimumPrice='"+minimumBid+"';");
	
	if(rs.next()){
		auctionId = rs.getInt("auctionID");
	}
	
	st.executeUpdate("insert into auctionItem (auctionId,itemNumber) values ('"+auctionId+"','"+itemNumber+"');");
	out.println("Auction Number "+ auctionId +" Posted <a href='userLanding.jsp'> Back to Home.</a>");

%>
</body>
</html>