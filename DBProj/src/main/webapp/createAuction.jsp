<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Date" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
	.hidden1 {
		display:none;
	}
	.hidden2 {
		display:none;
	}
	.hidden3 {
		display:none;
	}
	
</style>

	<script type="text/javascript">
		function showHide(){
			var top = document.getElementById("top");
			var hiddeninputs = document.getElementsByClassName("hidden1");
			var bottom = document.getElementById("bottom");
			var hiddeninputs2 = document.getElementsByClassName("hidden2");
			var foot = document.getElementById("foot");
			var hiddeninputs3 = document.getElementsByClassName("hidden3");
		
			for(var i = 0; i !=hiddeninputs.length; i++){
				if( top.checked==true){
					hiddeninputs[i].style.display = "block";
				}
				else {
					hiddeninputs[i].style.display = "none";
				}
			}
			
			for(var i = 0; i !=hiddeninputs2.length; i++){
				if( bottom.checked==true){
					hiddeninputs2[i].style.display = "block";
				}
				else {
					hiddeninputs2[i].style.display = "none";
				}
			}
			
			for(var i = 0; i !=hiddeninputs3.length; i++){
				if( foot.checked==true){
					hiddeninputs3[i].style.display = "block";
				}
				else {
					hiddeninputs3[i].style.display = "none";
				}
			}
		}
	</script>
</head>
<body>

Pick Clothing Descriptions
	<a href='userLanding.jsp'> Back to Home.</a><br>
     <form action="validAuction.jsp" method="get">
       	Color: <input type="text" name="itemColor"/> <br/>
       	Brand: <input type="text" name="itemBrand"/> <br/>
       	Material <input type="text" name="itemMaterial"/> <br/>
       	Description <textarea rows="4" cols="50" name=itemDescription></textarea> <br/>
       	Closing Date <input type="text" name="closingDate"/> YYYY-MM-DD <br>
       	Closing Time <input type="time" name="closingTime"/> HH:MM <br>
       	Minimum Bid <input type="number" min="0" step="any" name="minimumBid"/> <br>
       	<input type="radio" name="type" value="Top" id="top" onclick="showHide()"/>Top <br>
	   	<input type="radio" name="type" value="Bottom" id="bottom" onclick="showHide()"/>Bottom <br>
	   	<input type="radio" name="type" value="FootWear" id="foot"onclick="showHide()"/>Foot Wear <br>
	   	
	   	
	   	<label class="hidden1">Neck Width: </label> <input class="hidden1" type="number" name="neckWidth"/>
     	<label class="hidden1">Sleeve Length: </label> <input class="hidden1" type="number" name="sleeveLength"/> 
     	<label class="hidden1">Shoulder Width: </label> <input class="hidden1" type="number" name="shoulderWidth"/>
     	<label class="hidden2">Inseam Length: </label> <input class="hidden2" type="number" name="inseamLength"/>
     	<label class="hidden2">Waist Size: </label> <input class="hidden2" type="number" name="waistSize"/> 
     	<label class="hidden3">Foot Width: </label> <input class="hidden3" type="number" name="footWidth"/>
     	<label class="hidden3">Foot Size: </label> <input class="hidden3" type="number" name="footSize"/> 
	   <input type="submit" value="Continue"/>
     </form>
     
</body>
</html>