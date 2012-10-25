<cfparam name="URL.authorID" default="0" type="numeric" />

<cfif URL.authorID EQ 0>
  <cfset session.message = "Unable to confirm author to delete" />
	<cflocation url="authors.cfm" addToken="false" />
</cfif>

<cftry>
  <!--- Obtain author bean from database --->
  <cfset objAuthorBean = application.authorDAO.getAuthorByID(URL.authorID) />
  <cfcatch type="any">
	 <cfset session.message = "Unable to confirm author to delete" />
	 <cflocation url="authors.cfm" addToken="false" />
	</cfcatch>
</cftry>

<cftry>
	<cfset seriesDetails = application.SeriesGateway.getSeriesByAuthor(objAuthorBean.getAuthorID()) />
	<cfcatch type="any">
	 <cfset session.message = "Unable to confirm series information for author selected for deletion" />
	 <cflocation url="authors.cfm" addToken="false" />
	</cfcatch>
</cftry>

<cfif seriesDetails.recordCount GT 0>
	<cfloop query="seriesDetails">
		<cfif seriesDetails.bookCount GT 0>
    	<cftry>
    		<cfset booksGone = application.BookGateway.deleteBooksBySeries(seriesDetails.seriesID) />
	   		<cfif booksGone>
	   			<cfset session.message = " and books" />	
	   		</cfif>
	   		<cfcatch type="any">
		    	<cfset session.message = "Unable to remove books from author #objAuthorBean.getAuthorFullName()#">
		    	<cflocation url="authors.cfm" addToken="false" />
		  	</cfcatch>
	 		</cftry>	
		</cfif> 		
	</cfloop>
  
  

  <cftry>
		<cfset outcome =  application.SeriesGateway.deleteSeriesByAuthor(objAuthorBean.getAuthorID()) />
		<cfif >
			<cfset session.message = " and series" & session.message />
		<cfelse>
			<cfset session.message = " but not all series" & session.message />	
		</cfif>
	 <cfcatch type="any">
		  <cfset session.message = "Unable to remove series from author #objAuthorBean.getAuthorFullName()#" />
		  <cflocation url="authors.cfm" addToken="false" />
		</cfcatch>
	</cftry>
</cfif>

<cftry>
  <cfset outcome=application.authorDAO.deleteAuthorByID(objAuthorBean.getAuthorID()) />
  <cfif outcome>
  	<cfset session.message = "Author #objAuthorBean.getAuthorFullName()#" & session.message & " removed" />
  <cfelse>
  	<cfset session.message = "Unable to remove author #objAuthorBean.getAuthorFullName()#, but" & session.message & " removed" />	
  </cfif>
   
  <cfcatch type="any">
    <cfset session.message = "Unable to remove author #objAuthorBean.getAuthorFullName()#" />
	</cfcatch>
</cftry>

<cflocation url="authors.cfm" addToken="false" />