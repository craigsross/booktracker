/**
*  
* @file  /home/craig/workspace/bookTracker2/com/dataAccess/SeriesGateway.cfc
* @author  Craig Ross
* @description	I am the Series Gateway
*
*/

component output="false" displayname="SeriesGateway"  {
	
	// pseudo constructor
	variables.instance = {datasource=''};

	// constructor
	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor for the seriesgateway" { 
		variables.instance.datasource = arguments.datasource;
		return this;
	}	

	// public methods
	public query function getAllSeries() output="false" hint="I return all series data" {
		var result = '';
		var qAllSeries = new Query(datasource=variables.instance.datasource.getDSName());
		qAllSeries.setSQL("select seriesID, seriesName, seriesAuthor from series order by seriesName");
		result = qAllSeries.execute().getResult();
		return result;
	}

	public query function getAllSeriesSummary() output="false" hint="I return details about all series" {
		var result = '';
		var qAllSeriesSummary = new Query(datasource=variables.instance.datasource.getDSName());
		qAllSeriesSummary.setSQL("select s.seriesID, s.seriesName, a.authorFirstName, a.authorLastName, IFNULL(b.bookCount,0) AS bookCount, IFNULL(b1.paper,0) AS paper, IFNULL(b2.ebook,0) AS ebook from series s join authors a on s.seriesAuthor = a.authorID left join (select bookSeries, count(bookID) as bookCount from books group by bookSeries) as b on b.bookSeries = s.seriesID left join (select bookSeries, count(bookID) as paper from books where havePaperBook = true group by bookSeries) as b1 on s.seriesID = b1.bookSeries left join (select bookSeries, count(bookID) as ebook from books where haveEBook = true group by bookSeries) as b2 on s.seriesID = b2.bookSeries	order by s.seriesName");
		result = qAllSeriesSummary.execute().getResult();
		return result;
	}

	public query function getAllSeriesInfo() output="false" hint="I return a list of series and their authors" {
		var result = '';
		var qAllSeriesInfo = new Query(datasource=variables.instance.datasource.getDSName());
		qAllSeriesInfo.setSQL("select s.seriesID, s.seriesName, a.authorFirstName, a.authorLastName from series s join authors a on s.seriesAuthor=a.authorID order by s.seriesName");
		result = qAllSeriesInfo.execute().getResult();
		return result;
	}

	public query function getSeriesByAuthor(required numeric authorID) output="false" hint="I return a list of series by the supplied author" {
		var result = '';
		var qAuthorSeries = new Query(datasource=variables.instance.datasource.getDSName());
		qAuthorSeries.setSQL("SELECT s.seriesID, b1.bookCount FROM series s LEFT JOIN (SELECT b.bookSeries, COUNT(b.bookID) AS bookCount FROM books b GROUP BY b.bookSeries) AS b1 ON s.seriesID = b1.bookSeries WHERE s.seriesAuthor = :authorID ");
		qAuthorSeries.addParam(name="authorID", type="cf_sql_varchar", value=arguments.authorID);
		result = qAuthorSeries.execute().getResult();
		return result;
	}

	public boolean function deleteSeriesByAuthor(required numeric authorID) output="false" hint="I delete all empty series by the chosen author" {
		var result = true;
		var qDeleteSeriesByAuthor = new Query(datasource=variables.instance.datasource.getDSName());
		qDeleteSeriesByAuthor.setSQL("delete from series where seriesAuthor = :authorID ");
		try {
			qDeleteSeriesByAuthor.execute();
		} catch (database e) {
			result = false;
		}
		return result;
	}

}