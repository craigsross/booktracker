<cfparam name="URL.authorID" default="0" type="numeric" />

<cfif URL.authorID EQ 0>
  <cfset session.message = "Author ID not given to edit page" />
	<cflocation url="authors.cfm" addToken="false" />
</cfif>

<cftry>
  <!--- Obtain author bean from database --->
  <cfset objAuthorBean = application.authorDAO.getAuthorByID(URL.authorID) />
  <cfcatch type="any">
    <cfset session.message = "unable to load author bean" />
    <cflocation url="authors.cfm" addtoken="false" />
  </cfcatch>
</cftry>


<cfif objAuthorBean.getAuthorID() EQ 0>
  <cfset session.message = "That author is unkown" />
	<cflocation url="authors.cfm" addToken="false" /> 
</cfif>

<cfset pageTitle = "Edit Author &quot;#objAuthorBean.getAuthorFullName()#&quot;" />

<cfinclude template="header.cfm" />
<cfoutput>
  <p>This page allows you to edit an author</p>
  <h1>Edit Author &quot;#objAuthorBean.getAuthorFullName()#&quot;</h1>
  <form action="updateAuthor.cfm" method="post">
   <fieldset class="dataEntry">
		  <input type="hidden" name="authorID" value="#URL.authorID#"/ >
     <ul class="dataForm">
       <li>
          <label for="authorFirstName">First Name:</label>
          <input type="text" name="authorFirstName" id="authorFirstName" size="30" value="#objAuthorBean.getAuthorFirstName()#" />
        </li>
        <li>
          <label for="authorLastName">Last Name:</label>
          <input type="text" name="authorLastName" id="authorLastName" size="30" value="#objAuthorBean.getAuthorLastName()#"/>
        </li>
      </ul>
   </fieldset>
   <fieldset class="submit">
      <input type="submit" value="Save Author">
    </fieldset>
  </form>
  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="authors.cfm">Back to list of authors</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm" />