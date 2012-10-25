<cfparam name="URL.bookID" default="0" type="numeric" />

<cfif URL.bookID EQ 0>
  <cfset session.message = "Unable to identify book to delete" />
  <cflocation url="books.cfm" addToken="false" />
</cfif>

<cftry>
  <cfset objBook = application.bookDAO.getBookByID(URL.bookID) />
  <cfcatch type="any">
    <cfset session.message = "Unable to load book details from database" />
    <cflocation url="books.cfm" addtoken="false" />
  </cfcatch> 
</cftry>

<cfset pageTitle = "Confirm Book Removal" />
<cfinclude template="header.cfm" />
<cfoutput>
  <h1>Confirm book delete</h1>
	<p><a class="confirm" href="deleteBook.cfm?bookID=#objBook.getBookID()#">Remove #objBook.getBookName()#</a></p>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="viewSeries.cfm?seriesID=#objBook.getBookSeries()#">Back to &quot;#objBook.getSeriesName()#&quot; Series</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm" />