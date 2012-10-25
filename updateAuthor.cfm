<cfparam name="FORM.authorID" default="0" type="numeric" />
<cfparam name="FORM.authorFirstName" default="" type="string" />
<cfparam name="FORM.authorLastName" default="" type="string" />

<cfif FORM.authorID EQ 0>
  <cfset session.message = "Author information not passed to update" />
	<cflocation url="authors.cfm" />
</cfif>

<cfif NOT LEN(FORM.authorFirstName) OR NOT LEN(FORM.authorLastName)>
  <cfset session.message = "Authors need both a first name and a last name" />
	<cflocation url="editAuthor.cfm?authorID=#FORM.authorID#" />
</cfif>

<cftry>
  <!--- Obtain author bean from database --->
  <cfset objAuthor = createObject('component','com.beans.author').init(argumentCollection=FORM) />
  <cfset outcome = application.authorDAO.saveAuthor(author=objAuthor) />
  <cfcatch type="any">
    <cfset session.message = "Unable to process author update" />
    <cflocation url="authors.cfm" addtoken="false" />
  </cfcatch>
</cftry>

<cfif outcome>
	<cfset session.message = "Author details updated" />
<cfelse>
	<cfset session.message = "Author not updated" />
</cfif>

<cflocation url="authors.cfm" addToken="false" />