
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Track Request</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<center>
<header>
    <h2>Track Water Request</h2>
</header>

<form method="post">
    Name:
    <input type="text" name="name" required><br><br>
    <input type="submit" value="Track Request">
</form>

<%
String name = request.getParameter("name");
if(name != null)
{
    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/community_water",
            "root",
            "password"
        );
        String sql =
            "SELECT * FROM water_request WHERE resident_name=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        boolean found = false;
        while(rs.next())
        {
            found = true;
%>

<h3>Request Details</h3>

<p>
    Request ID:
    <%= rs.getInt("request_id") %>
</p>

<p>
    Name:
    <%= rs.getString("resident_name") %>
</p>

<p>
    Address:
    <%= rs.getString("address") %>
</p>

<p>
    Area:
    <%= rs.getString("area") %>
</p>

<p>
    Quantity:
    <%= rs.getInt("water_quantity") %> Litres
</p>

<p>
    Date:
    <%= rs.getString("request_date") %>
</p>

<p>
    Status:
    <%= rs.getString("status") %>
</p>

<hr>

<%
        }

        if(!found)
        {
            out.println("<h3>Request not found.</h3>");
        }
    }
    catch(Exception e)
    {
        out.println("Error: " + e.getMessage());
    }
}
%>
</center>
</body>
</html>
