<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="beans.MovieBean" %>

<%
    // Load all primary key values for the dropdown.
    MovieBean bean = new MovieBean();
    List<Integer> ids = new ArrayList<>();
    String error = null;

    try {
        ids = bean.getAllMovieIds();
    } catch (Exception e) {
        error = e.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Module 8 - Select Record to Update</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; max-width: 780px; }
        .desc { color: #555; }
        select, button { padding: 8px; font-size: 1rem; }
        button { cursor: pointer; margin-top: 12px; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
    </style>
</head>
<body>

<h1>Project Part 3: Update a Record</h1>
<p class="desc">
    Select a movie_id key from the database to update. The next page will load the record into input fields.
</p>

<div class="card">
    <h2>Select a Movie ID</h2>

    <form method="post" action="updateForm.jsp">
        <label for="movieId"><strong>movie_id:</strong></label><br />
        <select id="movieId" name="movieId" required>
            <option value="" disabled selected>Choose a movie_id...</option>
            <%
                for (Integer id : ids) {
            %>
                <option value="<%= id %>"><%= id %></option>
            <%
                }
            %>
        </select>
        <br />
        <button type="submit">Load Record</button>
    </form>

    <%
        if (error != null) {
    %>
        <div class="err"><strong>Error:</strong> <%= error %></div>
    <%
        }
    %>
</div>

</body>
</html>