<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="beans.MovieBean" %>

<%
     /*  
    Joshua Martin CSD430 Lab 6 - movieSelect.jsp - 02/08/2026
    Instructor: David Ostrowski
    what this jsp does:
    This page loads all movie_id values from the database and populates the dropdown menu.
    When the user picks one and submits, it sends the movie_id to movieDisplay.jsp to show the full record.
    */

    MovieBean bean = new MovieBean();
    List<Integer> ids = new ArrayList<>();

    try {
        ids = bean.getAllMovieIds();
    } catch (Exception e) {
        request.setAttribute("error", e.toString());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Module 5 - Movie Selector</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; max-width: 720px; }
        .row { margin-top: 12px; }
        select, button { padding: 8px; font-size: 1rem; }
        button { cursor: pointer; }
        .error { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .desc { color: #555; }
    </style>
</head>
<body>

    <h1>Module 5: Display Record from Database</h1>
    <p class="desc">
        This page loads all primary key values (<strong>movie_id</strong>) from the database.
        Pick one and submit to view the full movie record in a table.
    </p>

    <div class="card">
        <h2>Select a Movie ID</h2>

        <form method="post" action="movieDisplay.jsp">
            <div class="row">
                <label for="movieId"><strong>Movie ID:</strong></label><br />

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
            </div>

            <div class="row">
                <button type="submit">Display Record</button>
            </div>
        </form>

        <%
            if (request.getAttribute("error") != null) {
        %>
            <div class="error">
                <strong>DB Error:</strong>
                <%= request.getAttribute("error") %>
            </div>
        <%
            }
        %>
    </div>

</body>
</html>
