<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.josh.beans.MovieBean" %>

<%!
  /* Helper method:
    This escapes user-visible text so it doesn't break the HTML page. */
  private String esc(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
  }
%>

<%
  /* Scriptlet section (Java only):
    - Create the JavaBean
    - Load it with the same data you used in your Module 2 scriptlet assignment
    - Store it in request scope
    - Pull it back out to display

    This keeps Java logic out of the HTML. */

  MovieBean movie = new MovieBean();

  // Values from my module-2 movies assignment
  movie.setTitle("Deadpool and Wolverine");
  movie.setReleaseYear(2024);
  movie.setGenre("Action, Comedy, Superhero");
  movie.setDirector("Shawn Levy");
  movie.setMainActor("Ryan Reynolds");

  // Puts the bean into request scope so the page can access it cleanly
  request.setAttribute("movie", movie);

  // Pull it back out (now we will use the "m" variable throughout the HTML)
  MovieBean m = (MovieBean) request.getAttribute("movie");

  // Descriptions for the assignment (title + overall data description + record description)
  String overallDescription =
      "This page demonstrates using a JavaBean (MovieBean) to store a record and display it in an HTML table.";

  String recordDescription =
      "This record represents one movie entry using data from my Module 2 scriptlet assignment.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>MovieBean Data Display</title>

  <style>
    /* Simple styling so it looks organized and easy to read */
    body { font-family: Arial, sans-serif; margin: 24px; }
    .wrap { max-width: 900px; margin: 0 auto; }
    table { width: 100%; border-collapse: collapse; margin-top: 14px; }
    th, td { border: 1px solid #ccc; padding: 10px; vertical-align: top; }
    th { background: #f3f3f3; text-align: left; width: 220px; }
    .note { color: #444; }
  </style>
</head>

<body>
  <div class="wrap">
    <h1>JavaBean Data Display</h1>

    <!-- Overall description (assignment requirement) -->
    <p class="note">
      <strong>Overall data description:</strong>
      <%= esc(overallDescription) %>
    </p>

    <!-- Record description (assignment requirement) -->
    <p class="note">
      <strong>Record description:</strong>
      <%= esc(recordDescription) %>
    </p>

    <!-- Small header about what record we’re looking at -->
    <p class="note">
      <strong>Movie:</strong> <%= esc(m.getTitle()) %> (<%= esc(m.getSubtitle()) %>)
    </p>

    <!--
      Main requirement:
      Display data in an HTML table format.
      Also include field descriptions in a separate column.
    -->
    <table>
      <tr>
        <th>Field</th>
        <th>Value</th>
        <th>Field Description</th>
      </tr>

      <tr>
        <td>Title</td>
        <td><%= esc(m.getTitle()) %></td>
        <td>The name of the movie.</td>
      </tr>

      <tr>
        <td>Release Year</td>
        <td><%= m.getReleaseYear() %></td>
        <td>The year the movie was released.</td>
      </tr>

      <tr>
        <td>Genre</td>
        <td><%= esc(m.getGenre()) %></td>
        <td>The main category or categories for the movie.</td>
      </tr>

      <tr>
        <td>Director</td>
        <td><%= esc(m.getDirector()) %></td>
        <td>The director of the movie.</td>
      </tr>

      <tr>
        <td>Main Actor</td>
        <td><%= esc(m.getMainActor()) %></td>
        <td>The main actor highlighted in this record.</td>
      </tr>
    </table>

    <!-- Just a simple link so it feels like part of the project -->
    <p style="margin-top: 16px;">
      <a href="movie.jsp">← Back to movie.jsp</a>
    </p>
  </div>
</body>
</html>
