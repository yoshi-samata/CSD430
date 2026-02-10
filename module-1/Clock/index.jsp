<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Central Time</title>
  <style>
    body {
      margin: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: Arial, sans-serif;
      background: #fafafa;
    }

    #clock {
      font-size: 72px;
      font-weight: 700;
      letter-spacing: 1px;
    }
  </style>
</head>
<body>
  <div id="clock">Loading, hold on buddy...</div>

  <script>
    function updateCentralTime() {
      const now = new Date();
      const fmt = new Intl.DateTimeFormat("en-US", {
        timeZone: "America/Chicago",
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: true
      });
      document.getElementById("clock").textContent = fmt.format(now);
    }

    updateCentralTime();
    setInterval(updateCentralTime, 1000);
  </script>
</body>
</html>
