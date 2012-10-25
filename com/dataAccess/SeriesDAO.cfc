/**
*  
* @file  /home/craig/workspace/bookTracker2/com/dataAccess/SeriesDAO.cfc
* @author  Craig Ross
* @description Data Access Object for the Series Class
*
*/

component output="false" displayname="SeriesDAO"  {
	
	//pseudo constructor
	variables.instance = {datasource=''};

	//constructor
	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor for the SeriesDAO" { 
		variables.instance.datasource = arguments.datasource;
		return this;
	}	

	//public methods

	public boolean function saveSeries(required com.beans.series series) output="false" hint="I save the supplied series to the database" {
		var outcome = '';		
		if (exists(arguments.series)) {
			outcome = updateSeries(arguments.series);
		} else {
			outcome = createSeries(arguments.series);
		}
		return outcome;
	}
	
	
	public any function getSeriesByID(required numeric seriesID) output="false" hint="I return a series bean populated with the identified series" {
		var objSeries = '';
		var seriesData = '';
		var qRead = new Query(datasource = variables.instance.datasource.getDSName());
		qRead.setSQL("select seriesID, seriesName, seriesAuthor from series where seriesID = :seriesID");
		qRead.addParam(name="seriesID", type="cf_sql_integer", value=arguments.seriesID);
		try {
			seriesData = qRead.execute().getResult();
			if (seriesData.recordcount) {
				objSeries = createObject('component', 'bookTracker2.com.beans.series').init(seriesID=seriesData.seriesID, seriesName=seriesData.seriesName, seriesAuthor=seriesData.seriesAuthor);
			} else {
				objSeries = createObject('component', 'bookTracker2.com.beans.Series').init();
			}
		} catch (any e) {
			objSeries = createObject('component', 'bookTracker2.com.beans.Series').init();
		}	
		return objSeries;
	}
		

public boolean function deleteSeriesByID(required numeric seriesID) output="false" hint="I delete the provided series" {
	var qDelete = new Query(datasource = variables.instance.datasource.getDSName());
	qDelete.setSQL("delete from series where seriesID = :seriesID");
	qDelete.addParam(name="seriesID", type="cf_sql_integer", value=arguments.seriesID);
	try {
		qDelete.execute();
	} catch (database e) {
		return false;
	}
	return true;
}



	//private methods

	private boolean function exists(required com.beans.series series) output="false" hint="I return true if a series exists in the database" {
		var result = '';
		var qExists = new Query(datasource = variables.instance.datasource.getDSName());
		qExists.setSQL("select count(1) as idExists from series where seriesID = :seriesID");
		qExists.addParam(name="seriesID", type="cf_sql_varchar", value=arguments.series.getSeriesID());
		result = qExists.execute().getResult();
		if (result.idExists) {
			return true;
		} else {
			return false;
		}
	}

	private boolean function createSeries(required com.beans.series series) output="false" hint="I save the supplied series to the database" {
		var result = '';
		var qCreate = new Query(datasource = variables.instance.datasource.getDSName());
		qCreate.setSQL("insert into series(seriesName,seriesAuthor) values ( :seriesName , :seriesAuthor ) ");
		qCreate.addParam(name="seriesName", type="cf_sql_varchar", value=arguments.series.getSeriesName());
		qCreate.addParam(name="seriesAuthor", type="cf_sql_integer", value=arguments.series.getSeriesAuthor());
		try {
			result = qCreate.execute();
			if (result.getPrefix().generatedKey) {
				return true;
			} else {
				return false;
			}
		} catch (any e) {
			return false;
		}
	}

	private boolean function updateSeries(required com.beans.series series) output="false" hint="I update the supplied series details in the database" {
		var qUpdate = new Query(datasource = variables.instance.datasource.getDSName());
		qUpdate.setSQL("update series set seriesName = :seriesName, seriesAuthor = :seriesAuthor where seriesID = :seriesID");
		qUpdate.addParam(name="seriesName", type="cf_sql_varchar", value=arguments.series.getSeriesName());
		qUpdate.addParam(name="seriesAuthor", type="cf_sql_integer", value=arguments.series.getSeriesAuthor());
		qUpdate.addParam(name="seriesID", type="cf_sql_integer", value=arguments.series.getSeriesID());
		try {
			qUpdate.execute();
		} catch (any e) {
			return false;
		}
		return true;
	}
	

}