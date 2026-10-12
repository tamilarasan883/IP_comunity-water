
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Request</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<center>
<header>
    <h2>Update Request Status</h2>
</header>

<form method="post">

    Resident Name :
    <input type="text" name="name" required><br><br>
    New Status:
    <select name="status">
        <option value="Pending">Pending</option>
        <option value="Approved">Approved</option>
        <option value="Completed">Completed</option>
        <option value="Rejected">Rejected</option>
    </select>
    <br><br>

    <input type="submit" value="Update Status">

</form>
</center>


<%
String name = request.getParameter("name");
if(name != null)
{
    String status = request.getParameter("status");
    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/community_water",
            "root",
            "password"
        );

        String sql =
            "UPDATE water_request SET status=? WHERE resident_name=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setString(2, name);
        int i = ps.executeUpdate();
        if(i > 0)
        {
            out.println(
                "<h3>Request status updated successfully!</h3>"
            );
        }
        else
        {
            out.println(
                "<h3>Resident name not found.</h3>"
            );
        }
        ps.close();
        con.close();
    }
    catch(Exception e)
    {
        out.println("Error: " + e.getMessage());
    }
}
%>
</body>
</html>

