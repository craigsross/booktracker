<cfset pageTitle = "New Author" />

<cfinclude template="header.cfm" />
  <p>This page allows you to add a new author</p>
	<h1>New Author</h1>
  <form action="addAuthor.cfm" method="post">
	 <fieldset class="dataEntry">
		 <ul class="dataForm">
			 <li>
				  <label for="authorFirstName">First Name:</label>
				  <input type="text" name="authorFirstName" id="authorFirstName" size="30" />
				</li>
				<li>
          <label for="authorLastName">Last Name:</label>
          <input type="text" name="authorLastName" id="authorLastName" size="30" />
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
<cfinclude template="footer.cfm" />