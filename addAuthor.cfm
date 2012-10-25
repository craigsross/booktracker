<cfparam name="FORM.authorFirstName" default="" type="string" />
<cfparam name="FORM.authorLastName" default="" type="string" />

<cfif NOT LEN(FORM.authorFirstName) OR NOT LEN(FORM.authorLastName)>
  <cfset Session.message = "New Authors need both names filled in" />
	<cflocation url="newAuthor.cfm" />
</cfif>

<cftry>
  <!--- populate an author bean with data from form --->
  <cfset objAuthor=createObject('component','com.beans.author').init(argumentCollection=FORM) />
  <!--- send author bean to author DAO to save to database --->
  <cfset outcome=application.authorDAO.saveAuthor(author=objAuthor) />

  <cfif outcome>
     <cfset session.message = "Author added" />
  <cfelse>
    <cfset session.message = "Author not added" />
  </cfif>
  <cfcatch type="any">
    <cfset session.message = "Unable to save new author" />
  </cfcatch>
</cftry> 

<cflocation url="authors.cfm" addToken="false" />