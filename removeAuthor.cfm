<cfparam name="URL.authorID" default="0" type="numeric" />

<cfif URL.authorID EQ 0>
  <cfset session.message = "Author not passed to remove author page" />
	<cflocation url="authors.cfm" />
</cfif>

<cftry>
  <!--- Obtain author bean from database --->
  <cfset objAuthorBean = application.authorDAO.getAuthorByID(URL.authorID) />
	 <cfcatch type="any">
	 <cfset session.message = "Unable to confirm author details for removal" />
	 <cflocation url="authors.cfm" />
	</cfcatch>
</cftry>

<cfset pageTitle = "Confirm Removal of #objAuthorBean.getAuthorFullName()#" />
<cfinclude template="header.cfm" />
<cfoutput>
  <p>This page allows you to delete a series</p>
  <h1>Confirm Removal of Author &quot;#objAuthorBean.getAuthorFullName()#&quot;</h1>
  <p><a class="confirm" href="deleteAuthor.cfm?authorID=#objAuthorBean.getAuthorID()#">Remove #objAuthorBean.getAuthorFullName()# and all attached series and books</a></p>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="series.cfm">Back to Author list</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm" />