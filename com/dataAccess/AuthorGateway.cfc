/**
*  
* @file  /home/craig/workspace/bookTracker2/com/dataAccess/AuthorGateway.cfc
* @author  Craig Ross
* @description	I am the AuthorGateway class
*
*/

component output="false" displayname="AuthorGateway"  {
	
	//pseudo constructor
	variables.instance = {datasource=''};

	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor method for the AuthorGateway class" { 
		variables.instance.datasource = arguments.datasource;
		return this;
	}	

	// public methods
	public query function getAllAuthors() output="false" hint="I return a list of all authors" {
		var result = '';
		var qAllAuthors = new Query(datasource=variables.instance.datasource.getDSName());
		qAllAuthors.setSQL("select authorID, authorFirstName, authorLastName from authors order by authorLastName, authorFirstName");
		result = qAllAuthors.execute().getResult();
		return result;
	}

	public query function getAllAuthorSummary() output="false" hint="I return a summary of all authors" {
		var result = '';
		var qAllAuthorSummary = new Query(datasource=variables.instance.datasource.getDSName());
		qAllAuthorSummary.setSQL("select a.authorID, a.authorFirstName, a.authorLastName, COUNT(sc.seriesID) AS seriesCount, SUM(sc.bookCount) AS bookSum FROM authors a LEFT JOIN (SELECT s.seriesAuthor, s.seriesID, COUNT(b.bookID) AS bookCount FROM series s LEFT JOIN books b ON s.seriesID = b.bookSeries GROUP BY s.seriesAuthor, s.seriesID) AS sc ON a.authorID = sc.seriesAuthor	GROUP BY a.authorLastName, a.authorFirstName, a.authorID");
		result = qAllAuthorSummary.execute().getResult();
		return result;
	}
}	