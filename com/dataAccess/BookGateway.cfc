/**
*  
* @file  /home/craig/workspace/bookTracker2/com/dataAccess/BookGateway.cfc
* @author  
* @description
*
*/

component output="false" displayname="BookGateway"  {
	
	// pseudo constructor
	variables.instance = {datasource=''};

	// constructor
	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor for the BookGateway" { 
		variables.instance.datasource = arguments.datasource;
		return this;
	}	

	// public methods
	public query function getAllBooks() output="false" hint="I return all books in the database" {
		var result = '';
		var qAllBooks = new Query(datasource=variables.instance.datasource.getDSName());
		qAllBooks.setSQL("select bookID, bookName, bookSequence, havePaperBook, haveEBook from books");
		result = qAllBooks.execute().getResult();
		return result;
	}

	public query function getBooksBySeries(required numeric seriesID) output="false" hint="I return all books for the chosen series" {
		var result = '';
		var qBooksBySeries = new Query(datasource=variables.instance.datasource.getDSName());
		qBooksBySeries.setSQL("select bookID, bookName, bookSequence, havePaperBook, haveEBook from books where bookSeries = :seriesID ");
		qBooksBySeries.addParam(name="seriesID", type="cf_sql_integer", value=arguments.seriesID);
		result = qBooksBySeries.execute().getResult();
		return result;
	}

	public boolean function deleteBooksBySeries(required numeric seriesID) output="false" hint="I delete all books in the supplied series" {
		var outcome = true;
		var qDeleteBySeries = new Query(datasource=variables.instance.datasource.getDSName());
		qDeleteBySeries.setSQL("delete from books where bookSeries = :seriesID ");
		qDeleteBySeries.addParam(name="seriesID", type="cf_sql_integer", value=arguments.seriesID);
		try {
			qDeleteBySeries.execute();
		} catch (database e) {
			outcome = false;
		}
		return outcome;
	}

}