<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    // Retrieve form data
    String company = request.getParameter("company");
    String role = request.getParameter("role");
    String domain = request.getParameter("domain");
    String ctcParam = request.getParameter("ctc");
    String location = request.getParameter("location");
    String cgpaParam = request.getParameter("cgpa");
    String certificates = request.getParameter("certificates");

    // Debugging: Print all received parameters to check if they are being passed correctly
    out.println("Company received: " + company);
    out.println("Role received: " + role);
    out.println("Domain received: " + domain);
    out.println("CTC received: " + ctcParam);
    out.println("Location received: " + location);
    out.println("CGPA received: " + cgpaParam);
    out.println("Certificates received: " + certificates);

    // Validate that all fields are not null or empty
    if (company == null || company.trim().isEmpty()) {
        out.println("Company is required.");
    } else if (role == null || role.trim().isEmpty()) {
        out.println("Role is required.");
    } else if (domain == null || domain.trim().isEmpty()) {
        out.println("Domain is required.");
    } else if (ctcParam == null || ctcParam.trim().isEmpty()) {
        out.println("CTC is required.");
    } else if (location == null || location.trim().isEmpty()) {
        out.println("Location is required.");
    } else if (cgpaParam == null || cgpaParam.trim().isEmpty()) {
        out.println("CGPA is required.");
    } else {
        // Convert numeric values safely
        int ctc = 0;
        double cgpa = 0.0;
        try {
            ctc = Integer.parseInt(ctcParam);
            cgpa = Double.parseDouble(cgpaParam);
        } catch (NumberFormatException e) {
            out.println("Invalid number format for CTC or CGPA.");
        }

        // Insert data into database
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/projects", "root", "dhfm");

            String sql = "INSERT INTO jobs (Company, Role, Domain, ctc, location, cgpa, certficates) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);

            // Set parameters for SQL query
            pstmt.setString(1, company);
            pstmt.setString(2, role);
            pstmt.setString(3, domain);
            pstmt.setInt(4, ctc);
            pstmt.setString(5, location);
            pstmt.setDouble(6, cgpa);
            pstmt.setString(7, certificates);

            // Execute update
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("addsuccess.html");  // Redirect to success page
            } else {
                out.println("Failed to add job posting.");
            }
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("Driver not found: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    }
%>
