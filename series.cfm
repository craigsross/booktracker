<cfset pageTitle = "Book Series" />

<cftry>
  <cfset seriesList = application.SeriesGateway.getAllSeriesSummary() />
  <cfcatch type="any">
    <cfset session.message = "Unable to load series information" />
    <cflocation url="index.cfm" addtoken="false" />
  </cfcatch>
</cftry>

<cfinclude template="header.cfm" />
  <p>This section will allow you to work with series</p>
  <h2>List of current series</h2>
  <table class="sortTable">
    <thead>
      <tr>
        <th>Series Name</th>
        <th>Series Author</th>
        <th>No of Books</th>
        <th>Books Owned</th>
				<th>EBooks Owned</th>
        <th>Options</th>
       </tr>
     </thead>
     <tbody>
			 <cfoutput query="seriesList">
        <tr class="<cfif (seriesList.currentRow MOD 2) EQ 1>odd<cfelse>even</cfif>">
          <td><a href="editSeries.cfm?seriesID=#seriesList.seriesID#">#seriesList.seriesName#</a></td>
          <td>#seriesList.authorFirstName# #seriesList.authorLastName#</td>
          <td align="center">#seriesList.bookCount#</td>
          <td align="center">#seriesList.paper#</td>
					<td align="center">#seriesList.ebook#</td>
          <td><a href="newBook.cfm?seriesID=#seriesList.seriesID#">Add book to</a> / <a href="removeSeries.cfm?seriesID=#seriesList.seriesID#">Remove #seriesList.seriesName#</a></td>
        </tr>
			</cfoutput>
     </tbody>
  </table>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="newSeries.cfm">Add a new series</a></li>
		<li><a href="books.cfm">Work with books</a></li>
		<li><a href="authors.cfm">Work with authors</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
<cfinclude template="footer.cfm" />