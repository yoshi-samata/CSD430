<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    /*
      Java runs first on the server.
      We store our movie record here, then print it into HTML below.

      Reminder
      Keep HTML tags outside scriptlets.
    */

    String title = "Deadpool and Wolverine";
    int releaseYear = 2024;
    String genre = "Action, Comedy, Superhero";
    String director = "Shawn Levy";
    String mainActor = "Ryan Reynolds";
    String rated = "R";
    String favoritePart = "When Deadpool and Wolverine fought in the taxi.";
    String whyIEnjoyedIt = "It is funny, fast paced, and does not take itself too seriously, plus the cameo's are A1 Amazing.";

    // This creates a clean, readable string for the header
    String subtitle = genre + " • " + releaseYear + " • " + rated;
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Movie Record</title>
    <link rel="stylesheet" href="css/styles.css">
</head>

<body>
    <div class="layout">
        <div class="wrap">

            <header class="top">
                <div>
                    <h1><%= title %></h1>
                    <p class="sub"><%= subtitle %></p>
                </div>

                <div class="badge">
                    JSP Dynamic Page
                </div>
            </header>

            <main class="grid">
                <section class="card poster">
                    <div class="poster-box">
                        <div class="poster-title"><%= title %></div>
                        <div class="poster-meta"><%= releaseYear %></div>
                    </div>

                    <div class="quick">
                        <div class="quick-row">
                            <span class="k">Director:</span>
                            <span class="v"><%= director %></span>
                        </div>
                        <div class="quick-row">
                            <span class="k">Main Actor:</span>
                            <span class="v"><%= mainActor %></span>
                        </div>
                        <div class="quick-row">
                            <span class="k">Genre:</span>
                            <span class="v"><%= genre %></span>
                        </div>
                        <div class="quick-row">
                            <span class="k">Rating:</span>
                            <span class="v"><%= rated %></span>
                        </div>
                    </div>
                </section>

                <section class="card">
                    <h2>Movie Record Table</h2>
                <!--This table is formatted with CSS, but the values are printed from Java variables above. -->

                    <div class="table-wrap">
                        <table class="movie-table">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Year</th>
                                    <th>Genre</th>
                                    <th>Director</th>
                                    <th>Main Actor</th>
                                    <th>Rated</th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <td><%= title %></td>
                                    <td><%= releaseYear %></td>
                                    <td><%= genre %></td>
                                    <td><%= director %></td>
                                    <td><%= mainActor %></td>
                                    <td><%= rated %></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="two">
                        <div class="mini">
                            <h3>Favorite Part</h3>
                            <p><%= favoritePart %></p>
                        </div>

                        <div class="mini">
                            <h3>Why I Enjoyed It</h3>
                            <p><%= whyIEnjoyedIt %></p>
                        </div>
                    </div>

                    <!--
                        The browser only receives HTML and CSS.
                        Tomcat runs the JSP and injects these values before the page loads.
                -->
                </section>
            </main>
        </div>

        <!--Fix footer later to be at the bottom of the page.-->
            <footer class="footer">
                Built with JSP scriptlets & external CSS stylesheet by @Joshua Martin
            </footer>

    </div>
</body>
</html>
