<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
  /* CSRF check FIRST.
    If token fails, we block the request before doing any CRUD work. */
  String sessionToken = (String) session.getAttribute("CSRF_TOKEN");
  String formToken = request.getParameter("csrfToken");

  if (sessionToken == null || formToken == null || !sessionToken.equals(formToken)) {
    response.setStatus(403);
%>
    <!DOCTYPE html>
    <html><body>
      <h1>403 - Forbidden</h1>
      <p>Invalid CSRF token. Request blocked.</p>
    </body></html>
<%
    return;
  }

  // If CSRF token is valid, we can safely accept the inputs
  String customerName = request.getParameter("customerName");
  String issueTitle   = request.getParameter("issueTitle");
  String priority     = request.getParameter("priority");
  String status       = request.getParameter("status");
  String details      = request.getParameter("details");

  // In a full CRUD app, this is where you'd do JDBC INSERT into MySQL.
  // (We keep it simple here and just display what would be saved.)
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Ticket Created</title>
  <style>
    table { border-collapse: collapse; width: 800px; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background: #f2f2f2; width: 200px; }
  </style>
</head>
<body>
  <h1>Ticket Created</h1>

  <p>
    <strong>Overall data description:</strong>
    This page shows the submitted support ticket fields. In a CRUD project, these values would be inserted into MySQL using JDBC.
  </p>

  <table>
    <tr><th>Field</th><th>Value</th><th>Description</th></tr>
    <tr><td>Customer Name</td><td><%= customerName %></td><td>Who reported the issue.</td></tr>
    <tr><td>Issue Title</td><td><%= issueTitle %></td><td>Short summary of the problem.</td></tr>
    <tr><td>Priority</td><td><%= priority %></td><td>How urgent the ticket is.</td></tr>
    <tr><td>Status</td><td><%= status %></td><td>Current progress state.</td></tr>
    <tr><td>Details</td><td><%= details %></td><td>Longer explanation.</td></tr>
  </table>

  <p style="margin-top:16px;">
    <a href="ticketForm.jsp">Create another ticket</a>
  </p>
</body>
</html>
