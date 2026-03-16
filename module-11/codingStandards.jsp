<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

<head>

<title>Coding Standards Comparison</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#0d1117;
    color:#e6edf3;
    margin:40px;
}

/* Page title */

h1{
    text-align:center;
    margin-bottom:30px;
}

/* Layout */

.container{
    display:flex;
    gap:30px;
}

/* Code sections */

.section{
    flex:1;
    padding:20px;
    border-radius:10px;
}

/* Bad code styling */

.bad{
    background:#2d0f12;
    border:2px solid #ff4d4f;
}

/* Good code styling */

.good{
    background:#0f2d1a;
    border:2px solid #2ecc71;
}

/* Code blocks */

pre{
    background:#010409;
    padding:15px;
    border-radius:6px;
    overflow-x:auto;
    color:#79c0ff;
}

/* Explanation box */

.description{
    margin-top:20px;
    background:#161b22;
    padding:20px;
    border-radius:8px;
}

</style>

</head>

<body>

<h1>Coding Standards in Corporate Programming</h1>

<div class="container">

<!-- BAD CODE -->

<div class="section bad">

<h2>❌ Poor Coding Standards</h2>

<pre>

int X=5;
public void DOsomething(){
System.out.println("value:"+X);
}

</pre>

<p>
Problems with this code:
</p>

<ul>
<li>Variable name is unclear</li>
<li>Method naming does not follow camelCase</li>
<li>No indentation</li>
<li>No comments explaining the code</li>
<li>Hard to read in a large project</li>
</ul>

</div>


<!-- GOOD CODE -->

<div class="section good">

<h2>✅ Proper Corporate Coding Standards</h2>

<pre>

// Constant values use uppercase naming
private static final int MAX_USERS = 5;

// Method names follow camelCase convention
public void printUserCount() {

    System.out.println("User count: " + MAX_USERS);

}

</pre>

<p>
Why this is better:
</p>

<ul>
<li>Clear variable naming</li>
<li>Proper indentation</li>
<li>Readable formatting</li>
<li>Helpful comments</li>
<li>Follows Java naming conventions</li>
</ul>

</div>

</div>


<div class="description">

<h2>Why Coding Standards Matter</h2>

<p>
Coding standards are important in corporate programming environments because they make code easier for teams to read, understand, and maintain. 
In large companies, projects are often worked on by many developers over long periods of time. 
If every developer writes code in a different style, the project quickly becomes confusing and difficult to manage. 
Following consistent coding standards helps ensure that everyone on the team writes code in a similar way.
</p>

<p>
Standards typically include naming conventions, formatting rules, commenting practices, and file organization. 
These guidelines improve collaboration between developers and make debugging easier because the code structure is predictable.
</p>

</div>

</body>
</html>