<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="beans.MovieBean" %>

<%
    /*  
    Joshua Martin CSD430 Lab 6 - movieDisplay.jsp - 02/08/2026
    Instructor: David Ostrowski
    What this jsp does:
    receives the selected movie_id, queries the database for that one matching record, 
    and displays all of its fields in an HTML table with column headers..
   */

    

    String movieIdRaw = request.getParameter("movieId");
    int movieId = 0;

    MovieBean bean = new MovieBean();

    ResultSet rs = null;

    // We'll also keep references so we can close them safely.
    Statement stmtToClose = null;
    Connection connToClose = null;

    String error = null;

    try {
        movieId = Integer.parseInt(movieIdRaw);

        rs = bean.getMovieById(movieId);

        // Grab the connection so we can close it later.
        // This is a workaround because getMovieById returns a ResultSet.
        // In a more advanced setup we'd return a model object instead.
        stmtToClose = rs.getStatement();
        connToClose = stmtToClose.getConnection();

    } catch (Exception e) {
        error = e.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Module 5 - Movie Record</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        table { border-collapse: collapse; width: 100%; max-width: 980px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        thead th { background: #f5f5f5; }
        .desc { color: #555; max-width: 980px; }
        .error { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .btn { display: inline-block; margin-top: 16px; padding: 10px 12px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; }
        .btn:hover { background: #f8f8f8; }
    </style>
</head>
<body>

    <h1>Module 5: Selected Movie Record</h1>
    <p class="desc">
        You selected a single unique key (<strong>movie_id</strong>) from the database.
        Below is the full record displayed with each field in its own table column.
    </p>

    <%
        if (error != null) {
    %>
        <div class="error">
            <strong>Error:</strong>
            <%= error %>
        </div>

    <%
        } else {
            boolean found = false;
            if (rs != null && rs.next()) {
                found = true;
    %>

        <h2>Record for movie_id: <%= movieId %></h2>

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
                <tr>
                    <td><%= rs.getInt("movie_id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getInt("release_year") %></td>
                    <td><%= rs.getString("genre") %></td>
                    <td><%= rs.getBigDecimal("rating") %></td>
                    <td><%= rs.getString("director") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                </tr>
            </tbody>
        </table>

    <%
            }

            if (!found) {
    %>
        <div class="error">
            No record found for movie_id: <%= movieId %>
        </div>
    <%
            }
        }
    %>

    <a class="btn" href="movieSelect.jsp">Back to Dropdown</a>

<%
    // Always clean up DB resources
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (stmtToClose != null) stmtToClose.close(); } catch (Exception ignored) {}
    try { if (connToClose != null) connToClose.close(); } catch (Exception ignored) {}
%>

</body>
</html>
