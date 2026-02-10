<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Theoretical Website Review Form</title>
  <style>
    /* Keeping the styling simple so the form looks clean and easy to read */
    body { font-family: Arial, sans-serif; margin: 24px; }
    .wrap { max-width: 820px; margin: 0 auto; }
    fieldset { padding: 16px; margin-bottom: 16px; }
    label { display: block; margin-top: 10px; font-weight: 600; }
    input, select, textarea { width: 100%; padding: 8px; margin-top: 6px; }
    .row { display: flex; gap: 12px; }
    .row > div { flex: 1; }
    .inline { display: flex; gap: 12px; align-items: center; margin-top: 6px; }
    .inline input { width: auto; }
    button { padding: 10px 14px; cursor: pointer; }
    small { color: #444; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Website Review Form</h1>
     <!-- This is a review form for a "theoretical website".
      The goal is to collect a mix of different input types and 
      then submit it to a separate JSP page (reviewResult.jsp) to display the data. -->
    <p>
      Use this form to submit a review for a <strong>theoretical website</strong>.
      This collects feedback and displays it on a separate JSP page.
    </p>

    <!--
      Form Requirements Met:
      - 10 data entry points
      - 5+ input types (text, email, number, date, range, radio, select, checkbox, textarea)
      - Submits to a separate JSP file for display
    -->
    <form action="reviewResult.jsp" method="post">
      <fieldset>
        <legend><strong>Reviewer Info</strong></legend>

        <!-- 1) text input -->
        <label for="fullName">1) Full Name </label>
        <input id="fullName" name="fullName" type="text" required minlength="2" placeholder="Josh Martin" />

        <!-- 2) email input -->
        <label for="email">2) Email </label>
        <input id="email" name="email" type="email" required placeholder="you@example.com" />

        <div class="row">
          <div>
             <!-- 3) number input -->
            <label for="age">3) Age (number)</label>
            <input id="age" name="age" type="number" min="13" max="120" required />
            <small>We only collect this for general audience stats.</small>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend><strong>Review Details</strong></legend>

         <!-- 4) text input -->
        <label for="siteName">4) Website Name </label>
        <input id="siteName" name="siteName" type="text" required placeholder="ExampleSite.com" />

         <!-- 5) select input -->
        <label for="favoriteFeature">5) Favorite Feature </label>
        <select id="favoriteFeature" name="favoriteFeature" required>
          <option value="">-- Choose one --</option>
          <option value="Design">Design</option>
          <option value="Speed">Speed</option>
          <option value="Navigation">Navigation</option>
          <option value="Content">Content</option>
          <option value="Checkout / Ordering">Checkout / Ordering</option>
        </select>

       <!-- 6) radio input -->
        <label>6) Would you recommend the website to a friend?</label>
        <div class="inline">
          <label><input type="radio" name="recommend" value="Yes" required /> Yes</label>
          <label><input type="radio" name="recommend" value="No" /> No</label>
          <label><input type="radio" name="recommend" value="Maybe" /> Maybe</label>
        </div>

         <!-- 7) range input -->
        <label for="rating">7) Overall Rating (1–10)</label>
        <input id="rating" name="rating" type="range" min="1" max="10" value="7"
               oninput="document.getElementById('ratingValue').textContent=this.value;" />
        <small>Current rating: <strong id="ratingValue">7</strong></small>

        <!-- 8) checkbox group -->
        <label>8) What should be improved? </label>
        <div class="inline" style="flex-wrap: wrap;">
          <label><input type="checkbox" name="improvements" value="UI/Design" /> UI/Design</label>
          <label><input type="checkbox" name="improvements" value="Speed" /> Speed</label>
          <label><input type="checkbox" name="improvements" value="Mobile" /> Mobile</label>
          <label><input type="checkbox" name="improvements" value="Accessibility" /> Accessibility</label>
          <label><input type="checkbox" name="improvements" value="Content Clarity" /> Content Clarity</label>
        </div>

        <!-- 9) textarea input -->
        <label for="comments">9) Additional Comments below are appreciated. </label>
        <textarea id="comments" name="comments" rows="5" placeholder="Say anything you want here..."></textarea>
      </fieldset>

      <fieldset>
        <legend><strong>Extra</strong></legend>
        
        <!-- 10) single checkbox -->
        <label class="inline">
          <input type="checkbox" name="newsletter" value="Yes" />
          Check this box to send updates to your email.
        </label> 
        <!-- That checkbox sends "Yes" if checked.
          If they do not check it, the value will be null on the server,
          so we handle that on the results page. -->
      </fieldset>

      <!-- Submitting sends everything to reviewResult.jsp -->
      <button type="submit">Submit Review</button>
    </form>
  </div>
</body>
</html>
