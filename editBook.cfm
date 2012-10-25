<cfparam name="URL.bookID" default="0" type="numeric" />
<cfif URL.bookID EQ 0>
  <cfset session.message = "Unable to identify book to edit" />
	<cflocation url="books.cfm" addToken="false" />
</cfif>

<cfset pageTitle = "Edit Book Details" />

<cfset theScript=application.ValidateThis.getValidationScript(objectType="book") />
<cfhtmlhead text="#theScript#" />
<cfset initScript=application.ValidateThis.getInitializationScript() />
<cfhtmlhead text="#initScript#" />

<cftry>
  <cfset seriesInfo = application.SeriesGateway.getAllSeriesInfo() />
  <cfcatch type="any">
    <cfset session.message = "Unable to load series information" />
    <cflocation url="books.cfm" addtoken="false" />
  </cfcatch>
</cftry>

<cftry>
  <!--- Instantiate Bean --->
  <cfset objBook = application.bookDAO.getBookByID(URL.bookID) />
  <cfcatch type="any">
    <cfset session.message = "Unable to load book Details" />
    <cflocation url="books.cfm" addtoken="false" />
  </cfcatch>
</cftry>

<cfif objBook.getBookID() EQ 0>
  <cfset session.message = "That book was not found" />
  <cflocation url="books.cfm" addtoken="false" />
</cfif>

<cfinclude template="header.cfm" />
<cfoutput>
  <p>Use this page to edit a book in the tracker</p>
  <h1>Edit Book</h1>
  <form action="updateBook.cfm" method="post">
   <fieldset class="dataEntry">
	   <input name="bookID" type="hidden" value="#objBook.getBookID()#">
     <ul class="dataForm">
       <li>
          <label for="bookName">Book Title:</label>
          <input type="text" name="bookName" id="bookName" maxlength="60" value="#objBook.getBookName()#" />
        </li>
        <li>
          <label for="bookSeries">Choose Series:</label>
          <select name="bookSeries" id="bookSeries">
           <cfloop query="seriesInfo">
              <option value="#seriesInfo.seriesID#" <cfif #seriesInfo.seriesID# EQ #objBook.getBookSeries()#>selected="selected"</cfif>>#seriesInfo.seriesName# - #seriesInfo.authorFirstName# #seriesInfo.authorLastName#</option>
            </cfloop>
          </select>
        </li>
        <li>
          <label for="bookSequence">Order:</label>
          <input type="text" name="bookSequence" id="bookSequence" size="5" maxlength="5" value="#objBook.getBookSequence()#" />
        </li>
        <li>
          <label for="havePaperBook">I have the Paper Book:</label>
          <select name="havePaperBook" id="havePaperBook">
           <option value="No" <cfif NOT objBook.getHavePaperBook()>selected="selected"</cfif>>No</option>
           <option value="Yes" <cfif objBook.getHavePaperBook()>selected="selected"</cfif>>Yes</option>
          </select>
        </li>
        <li>
          <label for="haveEBook">I have the EBook:</label>
          <select name="haveEBook" id="haveEBook">
           <option value="No" <cfif NOT objBook.getHaveEBook()>selected="selected"</cfif>>No</option>
           <option value="Yes" <cfif objBook.getHaveEBook()>selected="selected"</cfif>>Yes</option>
          </select>
        </li>
      </ul>
   </fieldset>
   <fieldset class="submit">
    <input type="submit" value="Save Book" />
   </fieldset>
  </form>

  <hr />
  <h2>Choose an action</h2>
  <ul class="nav">
    <li><a href="viewSeries.cfm?seriesID=#objBook.getBookSeries()#">Back to #objBook.getSeriesName()#</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
</cfoutput>
<cfinclude template="footer.cfm" />