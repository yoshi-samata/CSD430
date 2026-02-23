<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="beans.MovieBean" %>

<%
    // Read submitted values.
    String movieIdRaw = request.getParameter("movieId");
    String title = request.getParameter("title");
    String releaseYearRaw = request.getParameter("release_year");
    String genre = request.getParameter("genre");
    String ratingRaw = request.getParameter("rating");
    String director = request.getParameter("director");

    int movieId = 0;
    int releaseYear = 0;
    double rating = 0.0;

    MovieBean bean = new MovieBean();

    String error = null;
    int rowsUpdated = 0;

    ResultSet rs = null;
    Statement stmtToClose = null;
    Connection connToClose = null;

    try {
        // Convert numeric inputs.
        movieId = Integer.parseInt(movieIdRaw);
        releaseYear = Integer.parseInt(releaseYearRaw);
        rating = Double.parseDouble(ratingRaw);

        // Update the record using the bean.
        rowsUpdated = bean.updateMovie(movieId, title, releaseYear, genre, rating, director);

        // Re-fetch the updated record for display.
        rs = bean.getMovieById(movieId);
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
    <title>Module 8 - Update Result</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        table { border-collapse: collapse; width: 100%; max-width: 1100px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        thead th { background: #f5f5f5; }
        .desc { color: #555; max-width: 1100px; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .msg { margin-top: 12px; color: #1b5e20; }
        .btn { display: inline-block; margin-top: 16px; padding: 10px 12px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; }
        .btn:hover { background: #f8f8f8; }
    </style>
</head>
<body>

<h1>Update Result</h1>
<p class="desc">
    This page updates the selected record using MovieBean, then displays the updated record below.
</p>

<%
    if (error != null) {
%>
    <div class="err"><strong>Error:</strong> <%= error %></div>
    <a class="btn" href="updateSelect.jsp">Back</a>
<%
    } else {
%>
    <div class="msg"><strong>Rows Updated:</strong> <%= rowsUpdated %></div>

    <h2>Updated Record (movie_id: <%= movieId %>)</h2>

    <table>
        <thead>
            <tr>
                <th>Field Name</th>
                <th>Field Type</th>
                <th>Value</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Show field names + SQL field types + the record values.
                if (rs != null && rs.next()) {
                    ResultSetMetaData meta = rs.getMetaData();
                    int colCount = meta.getColumnCount();

                    for (int i = 1; i <= colCount; i++) {
            %>
                        <tr>
                            <td><%= meta.getColumnName(i) %></td>
                            <td><%= meta.getColumnTypeName(i) %></td>
                            <td><%= rs.getString(i) %></td>
                        </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <a class="btn" href="movieUpdate.jsp">Back to Dropdown</a>
    <a class="btn" href="../index.jsp">Back to Project Index</a>
<%
    }
%>

<%
    // Close DB resources.
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (stmtToClose != null) stmtToClose.close(); } catch (Exception ignored) {}
    try { if (connToClose != null) connToClose.close(); } catch (Exception ignored) {}
%>

</body>
</html>