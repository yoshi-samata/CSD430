<%@ page contentType="text/html; charset=UTF-8" language="java" %>




<%!
 /*
    Quick helper function:
    This escapes text so if someone types weird HTML into a field,
    it doesn't break the page or inject anything.
  */
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
    /*
    Java runs first on the server.
    I grab everything that was submitted from the form here.
    Then later I display it in HTML (outside this scriptlet).
  */
  String fullName = request.getParameter("fullName");
  String email = request.getParameter("email");
  String age = request.getParameter("age");

  String siteName = request.getParameter("siteName");
  String favoriteFeature = request.getParameter("favoriteFeature");
  String recommend = request.getParameter("recommend");
  String rating = request.getParameter("rating");

  // Checkbox group comes back as an array (could be null if they select nothing)
  String[] improvements = request.getParameterValues("improvements");

  String comments = request.getParameter("comments");

  // Single checkbox: if unchecked, you get null, so we convert it into a clean Yes/No
  String newsletter = request.getParameter("newsletter");

  // Make checkbox single-field friendly (if unchecked, it will be null)
  if (newsletter == null) newsletter = "No";

  //server date to grab for data.
  java.time.LocalDate serverVisitDate = java.time.LocalDate.now();

  // Turn checkbox group into a readable string
  String improvementsText = "None selected";
  if (improvements != null && improvements.length > 0) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < improvements.length; i++) {
      sb.append(improvements[i]);
      if (i < improvements.length - 1) sb.append(", ");
    }
    improvementsText = sb.toString();
  }

 // Just a simple summary for the top of the page
 String summary = "This page shows the data submitted from the review form in a structured table.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Review Submission Results</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    .wrap { max-width: 900px; margin: 0 auto; }
    table { width: 100%; border-collapse: collapse; margin-top: 14px; }
    th, td { border: 1px solid #ccc; padding: 10px; vertical-align: top; }
    th { background: #f3f3f3; text-align: left; width: 220px; }
    .note { color: #444; }
    .top { display: flex; justify-content: space-between; gap: 12px; align-items: baseline; }
    .pill { background: #f3f3f3; padding: 6px 10px; border-radius: 12px; font-size: 12px; }
    a { text-decoration: none; }
  </style>
</head>

<body>
  <div class="wrap">
    <div class="top">
      <h1>Review Results</h1>
      <div class="pill">Submitted Data Display (JSP)</div>
    </div>

    <p class="note"><strong>Overall description:</strong> <%= esc(summary) %></p>
    <p class="note">
      <strong>Record description:</strong>
      This record contains reviewer info + feedback details for the website:
      <strong><%= esc(siteName) %></strong>
    </p>

    <!-- Display submitted data in an HTML table format -->
    <table>
      <tr>
        <th>Field</th>
        <th>Value</th>
        <th>Field Description</th>
      </tr>

      <tr>
        <td>Full Name</td>
        <td><%= esc(fullName) %></td>
        <td>The name of the person submitting the review.</td>
      </tr>

      <tr>
        <td>Email</td>
        <td><%= esc(email) %></td>
        <td>Contact email for the reviewer.</td>
      </tr>

      <tr>
        <td>Age</td>
        <td><%= esc(age) %></td>
        <td>Optional demographic info (basic audience stats).</td>
      </tr>

      <tr>
        <td>Visit Date</td>
        <td><%= serverVisitDate %></td>
        <td>Automatically captured on the server at submission time.</td>
      </tr>


      <tr>
        <td>Website Name</td>
        <td><%= esc(siteName) %></td>
        <td>The site being reviewed (theoretical website).</td>
      </tr>

      <tr>
        <td>Favorite Feature</td>
        <td><%= esc(favoriteFeature) %></td>
        <td>Which part of the site stood out the most.</td>
      </tr>

      <tr>
        <td>Recommend?</td>
        <td><%= esc(recommend) %></td>
        <td>Whether the reviewer would recommend the site to others.</td>
      </tr>

      <tr>
        <td>Overall Rating</td>
        <td><%= esc(rating) %> / 10</td>
        <td>A quick rating using a range slider.</td>
      </tr>

      <tr>
        <td>Improvements</td>
        <td><%= esc(improvementsText) %></td>
        <td>Areas the reviewer thinks need improvement (checkbox group).</td>
      </tr>

      <tr>
        <td>Additional Comments</td>
        <td><%= esc(comments) %></td>
        <td>Free-form feedback from the reviewer.</td>
      </tr>

      <tr>
        <td>Newsletter Updates</td>
        <td><%= esc(newsletter) %></td>
        <td>Whether the reviewer wants updates.</td>
      </tr>
    </table>

    <p style="margin-top: 16px;">
      <a href="reviewForm.jsp">← Back to the form</a>
    </p>
  </div>
</body>
</html>
