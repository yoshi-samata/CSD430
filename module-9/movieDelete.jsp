<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="beans.MovieBean" %>

<%
/*
    Joshua Martin CSD430 CRUD Project Part 4 - Project Delete Page - movieDelete.jsp - 02/15/2026
    Instructor: David Ostrowski

    What this page does:
    Shows all records in a table and gives a dropdown of movie_id keys to delete a record.
    After delete, it reloads and shows the updated table + updated dropdown.
*/

    MovieBean bean = new MovieBean();

    // These hold messages we show in the HTML.
    String message = null;
    String error = null;

    // If the user submitted a delete request, handle it first.
    String deleteIdRaw = request.getParameter("deleteId");
    if (deleteIdRaw != null && deleteIdRaw.length() > 0) {
        try {
            // Convert the selected key into an int.
            int deleteId = Integer.parseInt(deleteIdRaw);

            // Delete the record using the JavaBean.
            int rows = bean.deleteMovieById(deleteId);

            // Simple success message for the user.
            message = "Deleted movie_id " + deleteId + " (Rows affected: " + rows + ")";

        } catch (Exception e) {
            // If anything fails (bad id, DB error), show it.
            error = e.toString();
        }
    }

    // Pull all remaining keys for the dropdown.
    List<Integer> ids = new ArrayList<>();
    try {
        ids = bean.getAllMovieIds();
    } catch (Exception e) {
        error = (error == null) ? e.toString() : error + "\n" + e.toString();
    }

    // Pull all remaining rows for the table.
    ResultSet rs = null;
    Statement stmtToClose = null;
    Connection connToClose = null;

    try {
        rs = bean.getAllMovies();

        // Save these references so we can close everything at the end.
        stmtToClose = rs.getStatement();
        connToClose = stmtToClose.getConnection();

    } catch (Exception e) {
        error = (error == null) ? e.toString() : error + "\n" + e.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Project Part - Delete Records</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .desc { color: #555; max-width: 1100px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 16px; max-width: 1100px; }
        /* Cool "neon card" frame around the table */
        .table-frame{
        border: 2px solid rgba(0,255,255,0.35);
        box-shadow: 0 0 18px rgba(0,255,255,0.25), inset 0 0 14px rgba(0,255,255,0.10);
        border-radius: 18px;
        padding: 12px;
        background: rgba(10,10,18,0.75);
        max-width: 1100px;
        margin-top: 12px;
        }

        /* Keep table readable inside the frame */
        .movie-table{
        width: 100%;
        border-collapse: collapse;
        }

        .movie-table th,
        .movie-table td{
        border: 1px solid rgba(255,255,255,0.12);
        padding: 10px;
        text-align: left;
        }

        .movie-table thead th{
        background: rgba(255,255,255,0.10);
        }

        .movie-table tbody tr:hover{
        background: rgba(0,255,255,0.06);
        }
        select, button { padding: 8px; font-size: 1rem; }
        button { cursor: pointer; }
        .msg { margin-top: 12px; color: #1b5e20; white-space: pre-wrap; }
        .err { margin-top: 12px; color: #b00020; white-space: pre-wrap; }
        .row { margin-top: 12px; }
        .btnLink { display: inline-block; margin-top: 16px; padding: 10px 12px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; }
        .btnLink:hover { background: #f8f8f8; }
    </style>
</head>
<body>

<h1>Project Part: Delete Movie Records</h1>

<p class="desc">
    This page displays all movie records from the database in a table.
    Use the dropdown to select a movie_id key and delete that record.
    After deleting, the table and dropdown refresh so you can delete another record.
</p>

<div class="card">

    <h2>Current Records</h2>
    <p class="desc">
        Fields shown: movie_id, title, release_year, genre, rating, director, created_at.
        (Minimum 5 fields requirement is met.)
    </p>

    <%
        if (message != null) {
    %>
        <div class="msg"><strong><%= message %></strong></div>
    <%
        }
        if (error != null) {
    %>
        <div class="err"><strong>Error:</strong> <%= error %></div>
    <%
        }
    %>

    <!-- Always show the table header, even if there are zero rows -->
    <div class="table-frame">
        <table class="movie-table">
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
                // If rs is valid, loop through rows and print them.
                boolean printedAny = false;
                while (rs != null && rs.next()) {
                    printedAny = true;
            %>
                <tr>
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

                // If there are no rows left, show an empty body row (optional).
                if (!printedAny) {
            %>
                <tr>
                    <td colspan="7"><em>No records left in the table.</em></td>
                </tr>
            <%
                }
            %>
        </tbody>
        </table>
    </div>

    <div class="row">
        <h2>Delete a Record</h2>
        <p class="desc">
            Select a movie_id from the dropdown and click Delete. The page will refresh with remaining records.
        </p>

        <form method="post" action="movieDelete.jsp">
            <label for="deleteId"><strong>movie_id:</strong></label><br />

            <select id="deleteId" name="deleteId" <%= (ids.size() == 0 ? "disabled" : "") %> required>
                <option value="" disabled selected>
                    <%= (ids.size() == 0 ? "No keys left to delete" : "Choose a movie_id...") %>
                </option>

                <%
                    for (Integer id : ids) {
                %>
                    <option value="<%= id %>"><%= id %></option>
                <%
                    }
                %>
            </select>

            <button type="submit" <%= (ids.size() == 0 ? "disabled" : "") %>>Delete</button>
        </form>
    </div>

    <a class="btnLink" href="../index.jsp">Back to Project Index</a>
</div>

<%
    // Always close DB resources so we do not leak connections.
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (stmtToClose != null) stmtToClose.close(); } catch (Exception ignored) {}
    try { if (connToClose != null) connToClose.close(); } catch (Exception ignored) {}
%>

</body>
</html>