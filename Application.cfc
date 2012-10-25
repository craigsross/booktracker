component {
  this.name="booktracker";
  
  function onApplicationStart() {
  	application.Timeout=createTimeSpan(1, 0, 0, 0);
  	application.sessionTimeout=createTimeSpan(0, 0, 10, 0);
  	application.setClientCookies=false;
    application.datasource="bookTracker";
    var objDatasource = createObject('component', 'com.beans.datasource').init(DSName=application.datasource);
    var objAuthorDAO = createObject('component', 'com.dataAccess.AuthorDAO').init(datasource=objDatasource);
    application.authorDAO = objAuthorDAO;
    var objBookDAO = createObject('component', 'com.dataAccess.BookDAO').init(datasource=objDatasource);
    application.bookDAO = objBookDAO;
    var objSeriesDAO = createObject('component', 'com.dataAccess.SeriesDAO').init(datasource=objDatasource);
    application.SeriesDAO = objSeriesDAO;
    var objAuthorGateway = createObject('component','com.dataAccess.AuthorGateway').init(datasource=objDatasource);
    application.AuthorGateway = objAuthorGateway;
    var objSeriesGateway = createObject('component', 'com.dataAccess.SeriesGateway').init(datasource=objDatasource);
    application.SeriesGateway = objSeriesGateway;
    var objBookGateway = createObject('component', 'com.dataAccess.BookGateway').init(datasource=objDatasource);
    application.BookGateway = objBookGateway;
    ValidateThisConfig = {definitionPath="/bookTracker2/model/",JSRoot="/bookTracker2/scripts/"};
    application.ValidateThis = createObject("component","ValidateThis.ValidateThis").init(ValidateThisConfig);
  }
	
	function onSessionStart() {
		session.message = "Welcome to BookTracker";
	}
	
}