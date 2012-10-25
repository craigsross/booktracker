<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><cfoutput>#pageTitle#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/styles/booktracker.css" />
</head>
<body>
  <div id="head">
    <h1>Craig's Book Tracker</h1>
  </div>
  <div id="main">
	<cfif LEN(session.message)>
	 <cfoutput><h3 class="message">#session.message#</h3></cfoutput>
	 <cfset session.message = "" />
	</cfif>