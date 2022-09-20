<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style type="text/css">
	.hidden {
		display:none;
	}

</style>

<script type="text/javascript">

	function hide()
	{
		var bidLimit = document.getElementById("limit")
		var hiddeninputs = document.getElementsByClassName("hidden");
		
		for(var i = 0; i != hiddeninputs.length; i++){
			if(bidLimit.checked){
				hiddeninputs[i].style.display = "block";
			}
			else{
				hiddeninputs[i].style.display = "none";
			}
		}
	}
</script>

</head>
<body>
	<a href='userLanding.jsp'> Back to Home.</a><br>
	<form action = "validBid.jsp" method="get">
		Auction Id: <input type="number" name= "auctionId"/> <br/>
		Bid Amount: <input type="number" name="bidAmount"/> <br/>
		<input type = "checkbox" value = "automatic" id ="limit" name="automatic" onclick="hide()">Automatic: <br/>
		<label class="hidden">Bid Limit</label> <input class= "hidden"  type = "number" name="bidLimit"> <br/>
		<label class="hidden">Increment</label> <input class= "hidden" type = "number" name="increment"> <br/>
		<input type = "submit" value= "Place Bid"/>
	</form>
</body>
</html>