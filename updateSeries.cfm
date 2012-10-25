<cfparam name="FORM.seriesID" default="0" type="numeric" />
<cfparam name="FORM.seriesName" default="" type="string" />
<cfparam name="FORM.seriesAuthor" default="0" type="numeric" />

<cfif FORM.seriesID EQ 0 OR FORM.seriesAuthor EQ 0 OR NOT LEN(FORM.seriesName)>
  <cfset session.message = "Information not supplied to update series" />
	<cflocation url="series.cfm" addToken="false" />
</cfif>

<cftry>
	<cfset objSeriesBean = createObject('component', 'com.beans.series').init(argumentCollection=FORM) />
	<cfset outcome = application.seriesDAO.saveSeries(objSeriesBean) />
	<cfif outcome>
		<cfset session.message = "#FORM.seriesName# updated">
	<cfelse>
		<cfset session.message = "#FORM.seriesName#  not updated">	
	</cfif>
  
  <cfcatch type="any">
	 <cfset session.message = "Unable to update #FORM.seriesName#" />
	</cfcatch>
</cftry>

<cflocation url="series.cfm" addToken="false" />