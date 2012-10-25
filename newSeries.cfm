<cfparam name="URL.authorID" default="0" type="numeric" />

<cfset pageTitle = "New Series" />
<cftry>
	<cfset listAuthors = application.AuthorGateway.getAllAuthors() />
	<cfcatch type="any">
		<cfset session.message = "Unable to load author information" />
		<cflocation url="series.cfm" addtoken="false" />
	</cfcatch>
</cftry>

<cfinclude template="header.cfm" />
  <p>This page will allow you to enter a new book series</p>
  <h1>Add a New Series</h1>
  <form action="addSeries.cfm" method="post">
	 <fieldset class="dataEntry">
		<ul class="dataForm">
		  <li>
			 <label for="seriesName">Series Name:</label>
			 <input type="text" name="seriesName" id="seriesName" maxlength="30" />
			</li>
			<li>
			 <label for="seriesAuthor">Choose Author:</label>
			 <select name="seriesAuthor" id="seriesAuthor">
				  <cfoutput query="listAuthors">
					 <option value="#listAuthors.authorID#" <cfif URL.authorID EQ listAuthors.authorID>selected="selected"</cfif>>#listAuthors.authorFirstName# #listAuthors.authorLastName#</option>
					</cfoutput>
				</select>
			</li>
		</ul>
	 </fieldset>
	 <fieldset class="submit">
	   <input type="submit" value="Save Series" />
	 </fieldset>
	</form>

  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
		<cfif URL.authorID GT 0>
		  <li><a href="authors.cfm">Back to list of authors</a></li>
		<cfelse>
		  <li><a href="series.cfm">Back to list of book series</a></li>
		</cfif>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>