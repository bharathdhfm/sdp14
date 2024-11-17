<%@page import="java.sql.*" %>
<%
String brand=request.getParameter("Company");
String model=request.getParameter("Role");

try
{
	Connection con = null;
	  Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Class Loaded");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/projects", "root", "dhfm");
    System.out.println("Connection Established"); 
    PreparedStatement pstmt=con.prepareStatement("delete from jobs where Company=? and Role=?");
  
    pstmt.setString(1, Company);
    pstmt.setString(2, Role);
    int n=pstmt.executeUpdate();
    if(n>0)
    {
    	out.println("Deleted  Successfully");
    }
    else 
    {
    	out.println("Re-Enter The Details");
    }
	response.sendRedirect("deletedsuccessfully.html");
}
catch(Exception e)
{
	out.println(e);
}



%>