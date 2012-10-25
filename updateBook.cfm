<cfparam name="FORM.bookID" default="0" type="numeric" />
<cfparam name="FORM.bookName" default="" type="string" />
<cfparam name="FORM.bookSeries" default="0" type="numeric" />
<cfparam name="FORM.seriesName" type="string" default="" />
<cfparam name="FORM.bookSequence" default="0" type="numeric" /> 
<cfparam name="FORM.havePaperBook" default="No" type="string" />
<cfparam name="FORM.haveEBook" default="No" type="string" />

<cfif FORM.bookID EQ 0>
  <cfset session.message = "Unable to identify book to be updated" />
	<cflocation url="books.cfm" addToken="false" />
</cfif>

<cfif NOT LEN(FORM.bookName) OR FORM.bookSeries EQ 0>
  <cfset session.message = "Books require a name and a series" />
  <cflocation url="editBook.cfm?bookID=#FORM.bookID#" />
</cfif> 

<cftry>
  <!--- Populate Person Bean --->
  <cfset objBook = createObject('component','com.beans.book').init(argumentcollection=FORM) />
  <!--- Update book --->

  <cfset outcome = application.bookDAO.saveBook(objBook) />

<cfif outcome>
    <cfset session.message = "#objBook.getBookName()# updated" />
  <cfelse>
    <cfset session.message = "Unable to update #objBook.getBookName()#" />
  </cfif>
  <cfcatch type="any">
    <cfset session.message = "Unable to update #FORM.bookName#" />
    <cflocation url="books.cfm" addtoken="false" />
  </cfcatch>
</cftry>

<cflocation url="viewSeries.cfm?seriesID=#objBook.getBookSeries()#" addToken="false" />