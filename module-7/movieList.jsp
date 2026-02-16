<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="beans.MovieBean" %>

<%

    /*
        Joshua Martin CSD430 Lab 7 Project Part 2 - movieList.jsp - 02/15/2026
        Instructor: David Ostrowski

        What this page does:
        Uses the MovieBean to read all movie records from the database,
        then displays every record in an HTML table with a thead section for the field titles.
        Each database field is shown in its own table column.
    */


    // Create the bean so we can read data from the database.
    MovieBean bean = new MovieBean();

    // rs will hold our query results (all movie rows).
    ResultSet rs = null;

    // These are used to close the database connection safely at the end.
    Statement stmtToClose = null;
    Connection connToClose = null;

    // If something fails, we store the error here and show it in HTML.
    String error = null;

    try {
        // Ask the bean for all movie records.
        rs = bean.getAllMovies();

        // The ResultSet is tied to a Statement and Connection.
        // We grab them so we can close everything later (important).
        stmtToClose = rs.getStatement();
        connToClose = stmtToClose.getConnection();

    } catch (Exception e) {
        // If the DB fails to connect or query, store the error.
        error = e.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Module 7 - All Movies</title>
    <style>
        /* Simple styling to keep the table readable */
        body { font-family: Arial, sans-serif; margin: 24px; }
        table { border-collapse: collapse; width: 100%; max-width: 1100px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        thead th { background: #f5f5f5; }
        .desc { color: #555; max-width: 1100px; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .btn { display: inline-block; margin-top: 16px; padding: 10px 12px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; }
        .btn:hover { background: #f8f8f8; }
    </style>
</head>
<body>

    <h1>Module 7: All Movie Records</h1>

    <p class="desc">
        This page reads every record from the database using MovieBean and displays it in a table.
        Each column is a field from the database table.
    </p>

    <%
        // If we had a DB error, show it and do not attempt to print a table.
        if (error != null) {
    %>
        <div class="err"><strong>Error:</strong> <%= error %></div>
    <%
        } else {
    %>

    <!-- Table header uses thead so the field titles are clearly separated -->
    <table>
        <thead>
            <tr>
                <th>movie_id</th>
                <th>title</th>
                <th>release_year</th>
                <th>genre</th>
                <th>rating</th>
                <th>director</th>
                <th>created_at</th>
            </tr>
        </thead>

        <tbody>
            <%
                // Loop through every row returned from the query.
                while (rs != null && rs.next()) {
            %>
                <tr>
                    <!-- Each cell prints one field from the current row -->
                    <td><%= rs.getInt("movie_id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getInt("release_year") %></td>
                    <td><%= rs.getString("genre") %></td>
                    <td><%= rs.getBigDecimal("rating") %></td>
                    <td><%= rs.getString("director") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
        }
    %>

    <!-- Buttons to go back and add more records -->
    <a class="btn" href="movieCreate.jsp">Add Another Record</a>
    <a class="btn" href="../index.jsp">Back to Project Index</a>

<%
    // Always close DB resources so we do not leak connections.
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (stmtToClose != null) stmtToClose.close(); } catch (Exception ignored) {}
    try { if (connToClose != null) connToClose.close(); } catch (Exception ignored) {}
%>

</body>
</html>
