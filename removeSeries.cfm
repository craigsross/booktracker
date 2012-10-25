<cfparam name="URL.seriesID" default="0" type="numeric" />

<cfif URL.seriesID EQ 0>
  <cfset session.message = "Series information not supplied to remove series" />
	<cflocation url="series.cfm" addToken="false" />
</cfif>

<cftry>
  <cfset objSeriesBean = application.seriesDAO.getSeriesByID(URL.seriesID) />

  <cfcatch type="any">
    <cfset session.message="Unable to confirm series details" />
    <cflocation url="series.cfm" addtoken="false" />
  </cfcatch>
</cftry>


<cfset pageTitle = "Confirm Removal of #objSeriesBean.getSeriesName()#" />
<cfinclude template="header.cfm" />
<cfoutput>
	<p>This page allows you to delete a series</p>
  <h1>Confirm Removal of &quot;#objSeriesBean.getSeriesName()#&quot; Series</h1>
  <p><a class="confirm" href="deleteSeries.cfm?seriesID=#URL.seriesID#">Remove #objSeriesBean.getSeriesName()# and any books attached</a></p>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="series.cfm">Back to Series list</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm" />