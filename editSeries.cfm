<cfparam name="URL.seriesID" default="0" type="numeric" />

<cfif URL.seriesID EQ 0>
  <cfset session.message = "Unable to identify series for editing" />
	<cflocation url="series.cfm" addToken="false" />
</cfif>

<cftry>
  <cfset objSeriesBean = application.seriesDAO.getSeriesByID(URL.seriesID) />
  <cfcatch type="any">
	 <cfset session.message = "Unable to load series details" />
	 <cflocation url="series.cfm" addToken="false" />
	</cfcatch>
</cftry>

<cftry>
  <cfset listAuthors = application.AuthorGateway.getAllAuthors() />
  <cfcatch type="any">
	 <cfset session.message = "Unable to load author information" />
	 <cflocation url="series.cfm" addToken="false" />
	</cfcatch>
</cftry>

<cfset pageTitle = "Edit #objSeriesBean.getSeriesName()#" />

<cfinclude template="header.cfm" />
  <cfoutput>
  <p>This page will allow you to edit a book series</p>
  <h1>Edit &quot;#objSeriesBean.getSeriesName()#&quot; Series</h1>
  <form action="updateSeries.cfm" method="post">
   <fieldset class="dataEntry">
		<input type="hidden" name="seriesID" value="#URL.seriesID#" />
    <ul class="dataForm">
      <li>
       <label for="seriesName">Series Name:</label>
       <input type="text" name="seriesName" id="seriesName" maxlength="30" value="#objSeriesBean.getSeriesName()#" />
      </li>
      <li>
       <label for="seriesAuthor">Choose Author:</label>
       <select name="seriesAuthor" id="seriesAuthor">
          <cfloop query="listAuthors">
           <option value="#listAuthors.authorID#" <cfif listAuthors.authorID EQ objSeriesBean.getSeriesAuthor()>selected="selected"</cfif>>#listAuthors.authorFirstName# #listAuthors.authorLastName#</option>
          </cfloop>
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
    <li><a href="series.cfm">Back to list of book series</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
	</cfoutput>
  </div>