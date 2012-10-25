<cfparam name="URL.seriesID" default=0 type="numeric" /> 
<cfif URL.seriesID EQ 0>
  <cfset session.message = "Unknown series" />
	<cflocation url="books.cfm" addtoken="false" />
</cfif>

<cftry>
	<cfset seriesBean = application.SeriesDAO.getSeriesByID(URL.seriesID) />
  <cfcatch type="any">
	 <cfset session.message = "Unable to load information about the chosen series" />
	 <cflocation url = "books.cfm" addtoken="false" />
	</cfcatch>
</cftry>
<cftry>
	<cfset bookSummary = application.BookGateway.getBooksBySeries(seriesBean.getSeriesID()) />
  <cfcatch type="any">
	 <cfset session.message = "Unable to load series books" />
	 <cflocation url="books.cfm" addtoken="false" />
	</cfcatch>
</cftry>

<cfset pageTitle = "Books in &quot;#seriesBean.getSeriesName()#&quot; Series" />
<cfinclude template="header.cfm" />
<cfoutput>
<p>This page shows the books currently attached to the chosen series</p>
<h1>Books in the &quot;#seriesBean.getSeriesName()#&quot; Series</h1>
<cfif bookSummary.recordCount GT 0>
  <table class="sortTable">
    <thead>
	   <tr>
		   <th>Book Name</th>
		    <th>Order</th>
		    <th>Have the Paper Book</th>
		    <th>Have the EBook</th>
		    <th>Options</th>
	 	</tr>
  	</thead>
	 <tbody>
  	 <cfloop query="bookSummary">
		    <tr class="<cfif (bookSummary.currentRow MOD 2) EQ 1>odd<cfelse>even</cfif>">
		  	 <td><a href="editBook.cfm?bookID=#bookSummary.bookID#">#bookSummary.bookName#</a></td>
		  	 <td align="center">#bookSummary.bookSequence#</td>
  	 		 <td align="center" class="<cfif bookSummary.havePaperBook>true">Yes<cfelse>false">No</cfif></td>
  			 <td align="center" class="<cfif bookSummary.haveEBook>true">Yes<cfelse>false">No</cfif></td>
			   <td><a href="removeBook.cfm?bookID=#bookSummary.bookID#">Remove Book</a></td>
			 </tr>
		  </cfloop>
	 </tbody>
  </table>
<cfelse>
  <h3>No books recorded in this series</h3>
</cfif>
<hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="newBook.cfm?seriesID=#URL.seriesID#">Add a new book</a></li>
		<li><a href="books.cfm">Back to list of series</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm">