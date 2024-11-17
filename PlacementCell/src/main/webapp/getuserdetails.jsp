<%@page import="java.sql.*" %>
<%

// Get parameters from request
String name = request.getParameter("name");
String dob = request.getParameter("dob");
int id = Integer.parseInt(request.getParameter("id_number"));
String uname = request.getParameter("university_name");
float cgpa = Float.parseFloat(request.getParameter("cgpa"));  // Changed from int to float
String email = request.getParameter("email");
String pwd = request.getParameter("password");

%>

<%
try {
    // Load MySQL driver class
    Class.forName("com.mysql.cj.jdbc.Driver");  // Make sure the MySQL JDBC Driver is loaded
    System.out.println("Driver class loaded");
    
    // Establish connection
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/projects?useSSL=false&serverTimezone=UTC", 
        "root", 
        "dhfm"
    );
    System.out.println("Connection Established");

    // SQL query for inserting user details
    String sql = "INSERT INTO users (name, dob, id_number, university_name, cgpa, email, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    // Prepared Statement
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, dob);
    pstmt.setInt(3, id);
    pstmt.setString(4, uname);
    pstmt.setFloat(5, cgpa);  // Set float value for cgpa
    pstmt.setString(6, email);
    pstmt.setString(7, pwd);
    
    // Execute the query
    pstmt.executeUpdate();
    
    // Redirect to login page
    response.sendRedirect("userlogin.html");
    
    // Close resources
    pstmt.close();
    con.close();
} catch (Exception e) {
    // Print exception details
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
}

%>
