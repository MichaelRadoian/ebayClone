<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   Welcome to the BuyMe Auction Site!
   <br /> <br /> 
   	User Login
     <form action="checkLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br /> <br /> 
     New User Registration
     <form action="registerNewUser.jsp" method="POST">
       Username: <input type="text" name="new_Username"/> <br/>
       Password:<input type="password" name="new_Password"/> <br/>
       <input type="submit" value="Register New User"/>
     </form>
   </body>
</html>