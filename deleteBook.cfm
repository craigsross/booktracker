<cfparam name="URL.bookID" default="0" type="numeric" />

<cfif URL.bookID EQ 0>
  <cfset session.message = "Unable to identify book to delete" />
	<cflocation url="books.cfm" addToken="false" />
</cfif>

<cftry>
	<!--- Populate Book Bean for Links --->
	<cfset objBook = application.bookDAO.getBookByID(URL.bookID) />
	<!--- Delete book --->
	<cfset outcome = application.bookDAO.deleteBookByID(URL.bookID) />
	<cfif outcome>
		<cfset session.message = "#objBook.getBookName()# Deleted" />
	<cfelse>
		<cfset session.message = "Unable to delete #objBook.getBookName()#" />	
	</cfif>
	<cfcatch type="any">
		<cfset session.message = "Unable to delete book from database" />	
	</cfcatch>	
</cftry> 

<cflocation url="viewSeries.cfm?seriesID=#objBook.getBookSeries()#" addToken="false" />