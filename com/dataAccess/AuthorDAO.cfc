component displayName="AuthorDAO" output="false" hint="I am the authorDAO class" {

	//pseudo constructor
	variables.instance = {datasource=''};

	//constructor
	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor for the AuthorDAO class" {
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	//public methods
	public boolean function saveAuthor(required com.beans.author author) output="false" hint="I save a new author or update an existing author as required" {
		var success = '';
		if (exists(arguments.author)) {
			success = updateAuthor(arguments.author);
		} else {
			success = createNewAuthor(arguments.author);
		}
		return success;
	}

	public any function getAuthorByID(required numeric authorID) output="false" hint="I return an author bean populated with details of a specific author" {
		var qSearch = new Query(datasource="#variables.instance.datasource.getDSName()#");
		var objAuthor = '';
		var result = '';
		var authorData = '';
		qSearch.setSQL("select authorID, authorFirstName, authorLastName from authors where authorID = :authorID");
		qSearch.addParam(name="authorID", type="cf_sql_integer", value=arguments.authorID);
		result = qSearch.execute();
		authorData= result.getResult();
		if (authorData.recordCount) {
			objAuthor = createObject('component','bookTracker2.com.beans.author').init(authorID=authorData.authorID, authorFirstName=authorData.authorFirstName, authorLastName=authorData.authorLastName);
		}
		else {
			objAuthor = createObject('component','bookTracker2.com.beans.author').init();
		}
		return objAuthor;
	}

	public boolean function deleteAuthorByID(required numeric authorID) output="false" hint="I delete the author whose ID was passed" {
		var qDelete = new Query(datasource=variables.instance.datasource.getDSName());
		var outcome = true;
		try {
			qDelete.setSQL('delete from authors where authorID = :authorID');
			qDelete.addParam(name="authorID", type="cf_sql_integer", value=arguments.authorID);
			qDelete.execute();
			} catch (database e) {
				outcome = false;
			}
		return outcome;
	}
	
	//private methods

	private boolean function exists(required com.beans.author author) output="false" hint="I check if the supplied author is in the database" {
		var result = '';
		var qExists = new Query(datasource=variables.instance.datasource.getDSName());
		qExists.setSQL("select count(1) as idExists from authors where authorID = :authorID");
		qExists.addParam(name="authorID", type="cf_sql_integer", value=arguments.author.getAuthorID());
		result = qExists.execute().getResult();
		if (result.idExists) {
			return true;
		} else {
			return false;
		}
	}	

	private boolean function createNewAuthor(required com.beans.author author) output="false" hint="I insert a new author into the database" {
		var insertResult = '';
		var result = '';
		var qInsert = new Query(datasource="#variables.instance.datasource.getDSName()#");
		qInsert.setSQL("insert into authors(authorFirstName,authorLastName) values ( :authorFirstName , :authorLastName )" );
		qInsert.addParam( name="authorFirstName", type="cf_sql_varchar", value="#arguments.author.authorFirstName#" );
		qInsert.addParam( name="authorLastName", type="cf_sql_varchar", value="#arguments.author.authorLastName#" );
		try {
			result=qInsert.execute();
			if (result.getPrefix().generatedKey) {
				insertResult = true;
			} else {
				insertResult = false;
			}
		}
		catch(any e) {
			insertResult = false;
		} 
		return insertResult;
	}

	private boolean function updateAuthor(required com.beans.author author) output="false" hint="I update an authors details" {
		var qUpdate = new Query(datasource=variables.instance.datasource.getDSName());
		var outcome = true;
		try {
			qUpdate.setSQL("update authors set authorFirstName = :authorFirstName, authorLastName = :authorLastName where authorID = :authorID");
			qUpdate.addParam(name="authorFirstName", type="cf_sql_varchar", value=arguments.author.getAuthorFirstName());
			qUpdate.addParam(name="authorLastName", type="cf_sql_varchar", value=arguments.author.getAuthorLastName());
			qUpdate.addParam(name="authorID", type="cf_sql_integer", value=arguments.author.getAuthorID());
			qUpdate.execute();
		}
		catch (database e) {
			outcome = false;
		}
		return outcome;
	}
	
}
