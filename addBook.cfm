<cfparam name="FORM.bookName" default="" type="string" />
<cfparam name="FORM.bookSeries" default="0" type="numeric" />
<cfparam name="FORM.bookSequence" default="0" type="numeric" /> 
<cfparam name="FORM.havePaperBook" default="No" type="string" />
<cfparam name="FORM.haveEBook" default="No" type="string" />

<cfif NOT LEN(FORM.bookName) OR FORM.bookSeries EQ 0>
  <cfset session.message = "New books require a name and a series" />
	<cflocation url="newBook.cfm" />
</cfif> 

<!--- <cftry> --->
	<!--- Instantiate Book Bean --->
	<cfset objBook = createObject('component','com.beans.book').init(argumentCollection=FORM) />
	<!--- Save Bean --->
	<cfset outcome = application.bookDAO.saveBook(objBook) />
	<cfif outcome>
		<cfset session.message = "Book saved" />		
	<cfelse>
		<cfset session.message = "Book not saved" />
	</cfif>
	<!--- <cfcatch type="any">
		<cfset session.message = "Unable to save book" />
	</cfcatch>
</cftry> --->

 <cflocation url="viewSeries.cfm?seriesID=#FORM.bookSeries#" addToken="false"/>