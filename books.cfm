<cfset pageTitle="Series List" />
<cfset listBooks = application.SeriesGateway.getAllSeriesSummary() />
<cfinclude template="header.cfm" />
  <p>This section will allow you to work with books</p>
  <h2>List of book series</h2>
  <p>Choose a series to view the related books</p>
  <table class="sortTable">
    <thead>
      <tr>
        <th>Series Name</th>
        <th>Author</th>
        <th>Book Count</th>
      </tr>
    </thead>
    <tbody>
			<cfoutput query="listBooks">
        <tr class="<cfif (listBooks.currentRow MOD 2) EQ 1>odd<cfelse>even</cfif>">
          <td><a href="viewSeries.cfm?seriesID=#listBooks.seriesID#">#listBooks.seriesName#</a></td>
          <td>#listBooks.authorFirstName# #listBooks.authorLastName#</td>
          <td align="center">#listBooks.bookCount#</td>
        </tr>
			</cfoutput>
    </tbody>
  </table>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
		<li><a href="series.cfm">Work with series details</a></li>
		<li><a href="authors.cfm">Work with authors</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
<cfinclude template="footer.cfm">