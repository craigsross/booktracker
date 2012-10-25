<cfparam name="URL.seriesID" default="0" type="numeric" />

<cfif URL.seriesID EQ 0>
  <cfset session.message = "Series not passed to delete series" />
	<cflocation url="series.cfm" addToken="false" />
</cfif>

<cftry>
	<cfset objSeriesBean = application.seriesDAO.getSeriesByID(URL.seriesID) />
	<cfcatch type="any">
	  <cfset session.message = "Unable to confirm series details to delete" />
	  <cflocation url="series.cfm" addToken="false" />
	</cfcatch>
</cftry>

<cftry>
	<cfset booksGone = application.BookGateway.deleteBooksBySeries(objSeriesBean.getSeriesID()) />
  <cfif booksGone>
  	<cfset session.message = "Books removed " />
  <cfelse>
  	<cfset session.message = "Books not removed " />	
  </cfif>
  
  <cfcatch type="any">
	 <cfset session.message = "Unable to remove books from &quot;#objSeriesBean.getSeriesName()#&quot; series" />
	 <cflocation url="series.cfm" />
	</cfcatch>
</cftry>

<cftry>
	<cfset outcome = application.seriesDAO.deleteSeriesByID(URL.seriesID) />
	<cfif outcome>
		<cfset session.message = session.message & "and &quot;#objSeriesBean.getSeriesName()#&quot; deleted" />
	<cfelse>
		<cfset session.message = session.message & ". #objSeriesBean.getSeriesName()# not deleted" />
	</cfif>
  <cfcatch type="any">
	 <cfset session.message = session.message & "but unable to remove &quot;#objSeriesBean.getSeriesName()#&quot; series" />
	</cfcatch>
</cftry>

<cflocation url="series.cfm" addToken="false" />