<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="beans.MovieBean" %>

<%
    // message = success info we show after an insert.
    String message = null;

    // error = any error text we show if something breaks.
    String error = null;

    // This flag tells us if the user submitted the form or just opened the page.
    String submitted = request.getParameter("submitted");

    // Only run insert code when the user actually submits the form.
    if ("true".equals(submitted)) {
        try {
            // Grab user input from the form fields by "name".
            String title = request.getParameter("title");
            int releaseYear = Integer.parseInt(request.getParameter("release_year"));
            String genre = request.getParameter("genre");
            double rating = Double.parseDouble(request.getParameter("rating"));
            String director = request.getParameter("director");

            // Create the bean object so we can talk to the database.
            MovieBean bean = new MovieBean();

            // Insert the new movie into the database table.
            // movie_id is NOT in the form because it auto-increments in MySQL.
            int rows = bean.insertMovie(title, releaseYear, genre, rating, director);

            // Store a friendly success message for the HTML section below.
            message = "Record added successfully. Rows inserted: " + rows;

        } catch (Exception e) {
            // If anything fails (bad number input, DB issue, etc.) show the error.
            error = e.toString();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Module 7 - Add a Movie</title>
    <style>
        /* Basic styling just to keep it readable */
        body { font-family: Arial, sans-serif; margin: 24px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; max-width: 780px; }
        label { display: block; margin-top: 10px; }
        input { width: 100%; padding: 8px; font-size: 1rem; }
        button { margin-top: 12px; padding: 10px 12px; cursor: pointer; }
        .msg { margin-top: 12px; color: #1b5e20; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .desc { color: #555; }
        .links a { margin-right: 12px; }
    </style>
</head>
<body>

    <h1>Module 7: Create (Add a Record)</h1>

    <p class="desc">
        This page collects user input and inserts a new record into the database using MovieBean.
        The primary key (movie_id) is generated automatically by MySQL.
    </p>

    <div class="card">
        <h2>Add a Movie</h2>

        <!-- This form sends the user input back to this same page -->
        <form method="post" action="movieCreate.jsp">

            <!-- Hidden input is just a simple way to know this form was submitted -->
            <input type="hidden" name="submitted" value="true" />

            <!-- Each input "name" matches what we read in the scriptlet above -->
            <label for="title">Title</label>
            <input id="title" name="title" type="text" required />

            <label for="release_year">Release Year</label>
            <input id="release_year" name="release_year" type="number" min="1900" max="2100" required />

            <label for="genre">Genre</label>
            <input id="genre" name="genre" type="text" required />

            <label for="rating">Rating (0.0 - 9.9)</label>
            <input id="rating" name="rating" type="number" step="0.1" min="0" max="9.9" required />

            <label for="director">Director</label>
            <input id="director" name="director" type="text" required />

            <button type="submit">Add Movie</button>
        </form>

        <%
            // If insert worked, show the success message.
            if (message != null) {
        %>
            <div class="msg"><strong><%= message %></strong></div>
        <%
            }

            // If insert failed, show the error message.
            if (error != null) {
        %>
            <div class="err"><strong>Error:</strong> <%= error %></div>
        <%
            }
        %>

        <!-- Navigation links to make it easy to test -->
        <div class="links" style="margin-top:14px;">
            <a href="movieList.jsp">View All Records</a>
            <a href="../index.jsp">Back to Project Index</a>
        </div>
    </div>

</body>
</html>
