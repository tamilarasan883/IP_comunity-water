<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Water Request</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<center>
<header>
    <h2>Community Water Supply</h2>
</header>
<h4>Submit Water Request</h4>

<form method="post">

    Name:
    <input type="text" name="name"><br><br>

    Address:
    <input type="text" name="address"><br><br>

    Area:
    <input type="text" name="area"><br><br>

    Water Quantity:
    <input type="number" name="quantity"><br><br>

    Required Date:
    <input type="date" name="date"><br><br>

    <input type="submit" value="Submit Request">

</form>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/community_water",
        "root",
        "password"
    );
    if(request.getMethod().equalsIgnoreCase("POST"))
    {
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String area = request.getParameter("area");
        String quantity = request.getParameter("quantity");
        String date = request.getParameter("date");

        String insertSQL =
            "INSERT INTO water_request " +
            "(resident_name, address, area, water_quantity, request_date, status) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        ps = con.prepareStatement(insertSQL);
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, area);
        ps.setInt(4, Integer.parseInt(quantity));
        ps.setString(5, date);
        ps.setString(6, "Pending");

        ps.executeUpdate();

        ps.close();
        ps = null;

        out.println("<h3>Water request submitted successfully!</h3>");
    }

    String selectSQL = "SELECT * FROM water_request";
    ps = con.prepareStatement(selectSQL);
    rs = ps.executeQuery();
%>

<h3>Water Requests</h3>
<table border="1" cellpadding="10">

<tr>
    <th>Request ID</th>
    <th>Name</th>
    <th>Address</th>
    <th>Area</th>
    <th>Quantity</th>
    <th>Required Date</th>
    <th>Status</th>
</tr>

<%
    while(rs.next())
    {
%>
<tr>
    <td><%= rs.getInt("request_id") %></td>
    <td><%= rs.getString("resident_name") %></td>
    <td><%= rs.getString("address") %></td>
    <td><%= rs.getString("area") %></td>
    <td><%= rs.getInt("water_quantity") %></td>
    <td><%= rs.getString("request_date") %></td>
    <td><%= rs.getString("status") %></td>
</tr>
<%
    }
}
catch(Exception e)
{
    out.println("<h3>Error: " + e.getMessage() + "</h3>");
}

%>
</table>
</center>
</body>
</html>

