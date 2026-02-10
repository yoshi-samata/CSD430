<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Random" %>
<%
  // Session score tracking
  Integer wins = (Integer) session.getAttribute("wins");
  Integer losses = (Integer) session.getAttribute("losses");
  if (wins == null) wins = 0;
  if (losses == null) losses = 0;

  Random rand = new Random();
  int die1 = rand.nextInt(6) + 1;
  int die2 = rand.nextInt(6) + 1;
  int total = die1 + die2;

  String result;
  if (total >= 7) {
    wins++;
    result = "WIN";
  } else {
    losses++;
    result = "LOSS";
  }

  session.setAttribute("wins", wins);
  session.setAttribute("losses", losses);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Dice Game</title>
  <style>
    /* Center the card in the viewport */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: #fafafa;
    }

    .card {
      width: 520px;
      padding: 18px;
      border: 1px solid #ccc;
      border-radius: 12px;
      background: white;
      box-shadow: 0 8px 24px rgba(0,0,0,0.06);
    }

    .big { font-size: 26px; margin-bottom: 6px; }

    .row { display: flex; gap: 12px; margin: 10px 0; }

    .die {
      width: 90px;
      height: 90px;
      display: grid;
      place-items: center;
      font-size: 40px;
      border: 1px solid #999;
      border-radius: 12px;
      background: #fff;
    }

    .win { color: green; font-weight: bold; }
    .loss { color: #b00020; font-weight: bold; }

    .btn {
      display: inline-block;
      margin-top: 12px;
      margin-right: 10px;
      padding: 10px 14px;
      border: 1px solid #333;
      border-radius: 8px;
      text-decoration: none;
      color: inherit;
      background: #fff;
    }

    /* Bottom-right time */
    .timebox {
      position: fixed;
      right: 14px;
      bottom: 14px;
      padding: 10px 12px;
      border: 1px solid #ddd;
      border-radius: 10px;
      background: rgba(255,255,255,0.9);
      font-size: 13px;
      line-height: 1.3;
      box-shadow: 0 6px 18px rgba(0,0,0,0.06);
    }
    .timebox .label { font-weight: bold; }
  </style>
</head>

<body>
  <div class="card">
    <div class="big">🎲 Dice Game</div>
    <p>Refresh to roll. You win if the total is 7 or higher. Good luck.</p>

    <div class="row">
      <div class="die"><%= die1 %></div>
      <div class="die"><%= die2 %></div>
    </div>

    <p>Total: <strong><%= total %></strong></p>

    <p>
      Result:
      <span class="<%= result.equals("WIN") ? "win" : "loss" %>">
        <%= result %>
      </span>
    </p>

    <p>Wins: <strong><%= wins %></strong> | Losses: <strong><%= losses %></strong></p>

    <a class="btn" href="index.jsp">Roll again</a>
    <a class="btn" href="reset.jsp">Reset score</a>
  </div>

  <div class="timebox">
    <div class="label">Central Time</div>
    <div id="ct-time">Loading...</div>
  </div>

  <script>
    function updateCentralTime() {
      const now = new Date();
      const fmt = new Intl.DateTimeFormat("en-US", {
        timeZone: "America/Chicago",
        weekday: "short",
        year: "numeric",
        month: "short",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: true
      });
      document.getElementById("ct-time").textContent = fmt.format(now);
    }

    updateCentralTime();
    setInterval(updateCentralTime, 1000);
  </script>
</body>
</html>
