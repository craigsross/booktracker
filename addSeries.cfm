<cfparam name="FORM.seriesName" default="" type="string" />
<cfparam name="FORM.seriesAuthor" default=0 type="integer" />

<cfif NOT LEN(FORM.seriesName) OR FORM.seriesAuthor EQ 0>
  <cfset session.message = "Series name and author required to add the series" />
	<cflocation url="newSeries.cfm" addToken="false" />
</cfif>

<cftry>
	<!--- Populate the series bean with the values from the form --->
	<cfset objSeries = createObject('component', 'com.beans.series').init(argumentCollection=FORM) />
	<!--- Save Bean --->
	<cfset outcome = application.seriesDAO.saveSeries(objSeries) />
	<cfif outcome>
		<cfset session.message = "Series saved" />
	<cfelse>
		<cfset session.message = "Series not saved" />	
	</cfif>
 <cfcatch type="any">
		<cfset session.message = "Unable to save new series" />	
		<cflocation url="series.cfm" addtoken="false" />
	</cfcatch>
 </cftry>

<cflocation url="series.cfm" addToken="false" />