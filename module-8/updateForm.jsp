<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="beans.MovieBean" %>

<%
/*
    Joshua Martin CSD430 Lab - Project Part 3 - updateForm.jsp - 02/15/2026
    Instructor: David Ostrowski

    What this page does:
    Loads one record by movie_id and displays all non-key fields in input tags so the user can edit them.
    movie_id is shown but not editable, then submitted as a hidden field to updateResult.jsp.
*/

    // Read the selected key from the dropdown page.
    String movieIdRaw = request.getParameter("movieId");
    int movieId = 0;

    MovieBean bean = new MovieBean();

    ResultSet rs = null;
    Statement stmtToClose = null;
    Connection connToClose = null;

    // These variables pre-fill the form inputs.
    String title = "";
    int releaseYear = 0;
    String genre = "";
    String rating = "";
    String director = "";

    String error = null;

    try {
        // Convert the movieId from the request.
        movieId = Integer.parseInt(movieIdRaw);

        // Pull the selected record using the bean.
        rs = bean.getMovieById(movieId);

        // Keep references so we can close resources later.
        stmtToClose = rs.getStatement();
        connToClose = stmtToClose.getConnection();

        // Move to the first row and read values.
        if (rs != null && rs.next()) {
            title = rs.getString("title");
            releaseYear = rs.getInt("release_year");
            genre = rs.getString("genre");
            rating = rs.getBigDecimal("rating").toString();
            director = rs.getString("director");
        } else {
            error = "No record found for movie_id: " + movieId;
        }

    } catch (Exception e) {
        error = e.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Project Part 3 - Update Form</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; max-width: 900px; }
        .desc { color: #555; }
        label { display: block; margin-top: 10px; }
        input { width: 100%; padding: 8px; font-size: 1rem; }
        button { margin-top: 12px; padding: 10px 12px; cursor: pointer; }
        .keyBox { padding: 10px; border: 1px solid #ddd; border-radius: 8px; background: #f7f7f7; display: inline-block; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        a { text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<h1>Project Part 3: Update Record</h1>
<p class="desc">
    The key field (movie_id) is shown below and cannot be edited. Update the other fields and submit.
</p>

<div class="card">
<%
    if (error != null) {
%>
    <div class="err"><strong>Error:</strong> <%= error %></div>
    <p><a href="movieUpdate.jsp">Back to Dropdown</a></p>
<%
    } else {
%>

    <h2>Editing movie_id: <span class="keyBox"><%= movieId %></span></h2>

    <form method="post" action="updateResult.jsp">
        <!-- Keep movie_id for the update, but do NOT let the user edit it -->
        <input type="hidden" name="movieId" value="<%= movieId %>" />

        <label for="title">Title</label>
        <input id="title" name="title" type="text" value="<%= title %>" required />

        <label for="release_year">Release Year</label>
        <input id="release_year" name="release_year" type="number" min="1900" max="2100" value="<%= releaseYear %>" required />

        <label for="genre">Genre</label>
        <input id="genre" name="genre" type="text" value="<%= genre %>" required />

        <label for="rating">Rating (0.0 - 9.9)</label>
        <input id="rating" name="rating" type="number" step="0.1" min="0" max="9.9" value="<%= rating %>" required />

        <label for="director">Director</label>
        <input id="director" name="director" type="text" value="<%= director %>" required />

        <button type="submit">Update Record</button>
    </form>

<%
    }
%>
</div>

<%
    // Always close DB resources.
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (stmtToClose != null) stmtToClose.close(); } catch (Exception ignored) {}
    try { if (connToClose != null) connToClose.close(); } catch (Exception ignored) {}
%>

</body>
</html>