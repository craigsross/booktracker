<cfparam name="URL.seriesID" default="0" type="numeric" />
<cfset pageTitle = "Add a new book" />

<cftry>
  <cfset seriesInfo = application.SeriesGateway.getAllSeriesInfo() />
  <cfcatch type="any">
    <cfset session.message = "unable to load series information for new books" />
    <cflocation url="books.cfm" addToken="false" />
  </cfcatch>
</cftry>

<cfinclude template="header.cfm" />
  <p>Use this page to add a new book to the tracker</p>
	<h1>Add a New Book</h1>
	<form action="addBook.cfm" method="post">
	 <fieldset class="dataEntry">
		 <ul class="dataForm">
			 <li>
				  <label for="bookName">Book Title:</label>
				  <input type="text" name="bookName" id="bookName" maxlength="60" />
				</li>
				<li>
				  <label for="bookSeries">Choose Series:</label>
				  <select name="bookSeries" id="bookSeries">
					 <cfoutput query="seriesInfo">
						  <option value="#seriesInfo.seriesID#"<cfif seriesInfo.seriesID EQ URL.seriesID>selected="selected"</cfif>>#seriesInfo.seriesName# - #seriesInfo.authorFirstName# #seriesInfo.authorLastName#</option>
						</cfoutput>
					</select>
				</li>
				<li>
				  <label for="bookSequence">Order:</label>
				  <input type="text" name="bookSequence" id="bookSequence" size="5" maxlength="5" value="0" />
				</li>
				<li>
				  <label for="havePaperBook">I have the Paper Book:</label>
          <select name="havePaperBook" id="havePaperBook">
           <option value="No" selected="selected">No</option>
           <option value="Yes">Yes</option>
          </select>
				</li>
				<li>
				  <label for="haveEBook">I have the EBook:</label>
				  <select name="haveEBook" id="haveEBook">
					 <option value="No" selected="selected">No</option>
					 <option value="Yes">Yes</option>
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
    <li><a href="books.cfm">Back to list of books</a></li>
    <li><a href="index.cfm">Back to the homepage</a></li>
  </ul>
  </div>
<cfinclude template="footer.cfm" />