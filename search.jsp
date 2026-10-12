
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Request</title>
</head>

<body>
<h2>Search Water Requests</h2>
<form method="post">

    Enter Area:
    <input type="text" name="area" required>

    <input type="submit" value="Search">

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
    String area = request.getParameter("area");

    if(area != null)
    {
        String sql = "SELECT * FROM water_request WHERE area=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, area);
        ResultSet rs = ps.executeQuery();
        boolean found = false;
        while(rs.next())
        {
            found = true;
%>

<hr>
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
<%
        }
        if(!found)
        {
            out.println(
                "<h3>No requests found for this area.</h3>"
            );
        }

        rs.close();
        ps.close();
    }
    String selectSQL = "SELECT * FROM water_request";
    PreparedStatement ps2 = con.prepareStatement(selectSQL);
    ResultSet rs2 = ps2.executeQuery();

%>

<hr>
<h2>All Water Requests</h2>
<table border="1" cellpadding="10">
<tr>
    <th>Request ID</th>
    <th>Name</th>
    <th>Address</th>
    <th>Area</th>
    <th>Quantity</th>
    <th>Date</th>
    <th>Status</th>
</tr>
<%
while(rs2.next())
{
%>

<tr>

    <td>
        <%= rs2.getInt("request_id") %>
    </td>

    <td>
        <%= rs2.getString("resident_name") %>
    </td>

    <td>
        <%= rs2.getString("address") %>
    </td>

    <td>
        <%= rs2.getString("area") %>
    </td>

    <td>
        <%= rs2.getInt("water_quantity") %>
    </td>

    <td>
        <%= rs2.getString("request_date") %>
    </td>

    <td>
        <%= rs2.getString("status") %>
    </td>

</tr>

<%
}

}
catch(Exception e)
{
    out.println("Error: " + e.getMessage());
}
%>
</table>
</body>
</html>
