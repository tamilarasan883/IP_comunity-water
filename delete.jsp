<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Request</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<center>
<header>
    <h2>Cancel Water Request</h2>
</header>
<form method="post">
    Name :
    <input type="text" name="name"><br><br>
    <input type="submit" value="Cancel Request">
</form>

<%
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/community_water",
        "root",
        "password"
    );
    String name = request.getParameter("name");

    if(name != null && !name.equals(""))
    {
        String deleteSQL =
            "DELETE FROM water_request WHERE resident_name=?";

        PreparedStatement ps = con.prepareStatement(deleteSQL);
        ps.setString(1, name);
        int i = ps.executeUpdate();
        ps.close();
        if(i > 0)
        {
            out.println("<h3>Request cancelled successfully!</h3>");
        }
        else
        {
            out.println("<h3>Request not found.</h3>");
        }
    }
    String selectSQL = "SELECT * FROM water_request";
    PreparedStatement ps2 = con.prepareStatement(selectSQL);
    ResultSet rs = ps2.executeQuery();
%>
<h3>Current Water Requests</h3>
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
    <td>
        <%= rs.getInt("request_id") %>
    </td>
    <td>
        <%= rs.getString("resident_name") %>
    </td>
    <td>
        <%= rs.getString("address") %>
    </td>
    <td>
        <%= rs.getString("area") %>
    </td>
    <td>
        <%= rs.getInt("water_quantity") %>
    </td>
    <td>
        <%= rs.getString("request_date") %>
    </td>
    <td>
        <%= rs.getString("status") %>
    </td>
</tr>
<%
}

rs.close();
ps2.close();
con.close();

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

