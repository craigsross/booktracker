<cfset pageTitle = "List of Authors" />

<cftry>
  <cfset authorSummary = application.AuthorGateway.getAllAuthorSummary() />
  <cfcatch type="any">
    <cfset session.message = "Unable to load list of authors" />    
    <cflocation url="index.cfm" addtoken="false" />
  </cfcatch>  
</cftry>


<cfinclude template="header.cfm" />
  <p>This section allows you to work with authors</p>
  <h2>List of Current Authors</h2>
  <table class="sortTable">
    <thead>
      <tr>
        <th>Name</th>
        <th>Series Count</th>
        <th>Book Count</th>
        <th>Options</th>
      </tr>
    </thead>
    <tbody>
			<cfoutput query="authorSummary">
        <tr class="<cfif (authorSummary.currentRow MOD 2) EQ 1>odd<cfelse>even</cfif>">
          <td><a href="editAuthor.cfm?authorID=#authorSummary.authorID#">#authorSummary.authorFirstName# #authorSummary.authorLastName#</a></td>
          <td align="center">#authorSummary.seriesCount#</td>
          <td align="center">#authorSummary.bookSum#</td>
          <td><a href="newSeries.cfm?authorID=#authorSummary.authorID#">Add Series to</a> / <a href="removeAuthor.cfm?authorID=#authorSummary.authorID#">Remove #authorSummary.authorFirstName# #authorSummary.authorLastName#</a></td>
        </tr>
			</cfoutput>
    </tbody>
  </table>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="newAuthor.cfm">Add a new author</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
<cfinclude template="footer.cfm" />