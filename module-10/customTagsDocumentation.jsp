<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

<title>JSP Custom Tags Documentation</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#0d1117;
    color:#e6edf3;
    margin:0;
}

/* HEADER */

header{
    background:#161b22;
    padding:20px;
    border-bottom:1px solid #30363d;
}

header h1{
    margin:0;
}

/* LAYOUT */

.container{
    display:flex;
}

.sidebar{
    width:250px;
    background:#161b22;
    padding:20px;
    height:100vh;
    border-right:1px solid #30363d;
}

.sidebar a{
    display:block;
    color:#58a6ff;
    text-decoration:none;
    margin-bottom:10px;
}

.sidebar a:hover{
    text-decoration:underline;
}

.content{
    flex:1;
    padding:40px;
}

/* SECTION STYLE */

.section{
    margin-bottom:50px;
}

.section h2{
    border-bottom:1px solid #30363d;
    padding-bottom:10px;
}

/* CODE STYLE */

pre{
    background:#010409;
    color:#79c0ff;
    padding:15px;
    border-radius:6px;
    overflow-x:auto;
}

/* BUTTON */

.docButton{
    background:#238636;
    border:none;
    padding:12px 20px;
    color:white;
    font-size:16px;
    border-radius:6px;
    cursor:pointer;
}

.docButton:hover{
    background:#2ea043;
}

/* EMBED DOCUMENT */

iframe{
    border:1px solid #30363d;
    border-radius:6px;
}

</style>

</head>

<body>

<header>
<h1>JSP Custom Tags Developer  (>^_^)></h1>
</header>

<div class="container">

<!-- SIDEBAR -->

<div class="sidebar">

<h3>Sections</h3>

<a href="#overview">Overview</a>
<a href="#paper">Research Paper</a>
<a href="#example">Code Example</a>
<a href="#usage">JSP Usage</a>

</div>

<!-- MAIN CONTENT -->

<div class="content">

<!-- OVERVIEW -->

<div class="section" id="overview">

<h2>Overview</h2>

<p>
Custom tags in JSP allow developers to create reusable components that behave like HTML tags but execute Java code behind the scenes.
From my research I have gathered that this helps reduce duplicated code and keeps JSP pages easier to maintain.
Instead of writing Java scriptlets directly inside every page, developers can create a tag handler class and reuse it across the application.
</p>

<p>
In my opinion, custom tags are useful for larger applications where the same logic appears across multiple pages.
They also help separate presentation logic from business logic which improves readability and maintainability.
</p>

</div>

<!-- WORD DOCUMENT -->

<div class="section" id="paper">

<h2>Research Paper</h2>

<p>
The full research paper explaining custom tags can be opened or viewed below.
</p>

<a href="Martin_Mod10paper_CSD430.docx" target="_blank">
<button class="docButton">Open Research Paper</button>
</a>

<br><br>

<iframe
src="Martin_Mod10paper_CSD430.docx"
width="100%"
height="600px">
</iframe>

</div>

<!-- CODE EXAMPLE -->

<div class="section" id="example">

<h2>Custom Tag Handler Example</h2>

<pre>
package tags;

import javax.servlet.jsp.tagext.*;
import javax.servlet.jsp.*;
import java.io.IOException;

/*
 Simple custom tag example.
 When used inside a JSP page it prints a welcome message.
*/

public class WelcomeTag extends TagSupport {

    public int doStartTag() throws JspException {

        try {
            pageContext.getOut().println("Welcome to my JSP Custom Tag Example!");
        }
        catch(IOException e){
            throw new JspException("Error in WelcomeTag");
        }

        return SKIP_BODY;
    }
}
</pre>

</div>

<!-- JSP USAGE -->

<div class="section" id="usage">

<h2>Using the Custom Tag in a JSP Page</h2>

<pre>
&lt;%@ taglib prefix="custom" uri="/WEB-INF/customtags.tld" %&gt;

&lt;html&gt;
&lt;body&gt;

&lt;h2&gt;Example of a Custom JSP Tag&lt;/h2&gt;

&lt;custom:welcome /&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

</div>

</div>

</div>

</body>
</html>