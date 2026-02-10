<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>

<%
  /* Simple CSRF token:
    - store 1 token in session
    - reuse it until session ends */
  
  String csrfToken = (String) session.getAttribute("CSRF_TOKEN");
  if (csrfToken == null) {
    csrfToken = UUID.randomUUID().toString();
    session.setAttribute("CSRF_TOKEN", csrfToken);
  }

  // This makes the form action ALWAYS go to the correct webapp path
  String actionUrl = request.getContextPath() + "/ticketResult.jsp";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Create Support Ticket</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    .wrap { max-width: 800px; margin: 0 auto; }
    label { display:block; margin-top: 12px; }
    input, select, textarea { width: 100%; padding: 8px; margin-top: 6px; }
    .note { color:#444; font-size: 0.95rem; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Create Support Ticket</h1>

    <!-- quick debug for me so I know the JSP is executing -->
    <p class="note">Form loaded. Token starts with: <strong><%= csrfToken.substring(0, 8) %></strong></p>

    <form action="<%= actionUrl %>" method="post">
      <!-- CSRF token hidden field. HIDE IT. -->
      <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />

      <label>Customer Name
        <input type="text" name="customerName" required />
      </label>

      <label>Issue Title
        <input type="text" name="issueTitle" required />
      </label>

      <label>Priority
        <select name="priority">
          <option>Low</option>
          <option>Medium</option>
          <option>High</option>
        </select>
      </label>

      <label>Status</label>
      <div>
        <input type="radio" name="status" value="Open" checked /> Open
        <input type="radio" name="status" value="In Progress" /> In Progress
        <input type="radio" name="status" value="Closed" /> Closed
      </div>

      <label>Details
        <textarea name="details" rows="4"></textarea>
      </label>

      <p style="margin-top:16px;">
        <button type="submit">Create Ticket</button>
      </p>
    </form>
  </div>
</body>
</html>

