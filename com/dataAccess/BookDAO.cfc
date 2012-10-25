/**
*  
* @file  /home/craig/workspace/bookTracker2/com/dataAccess/BookDAO.cfc
* @author  
* @description
*
*/

component output="false" displayname="BookDAO" hint="I am the author DAO class"  {
	
	//pseudo constructor
	variables.instance = {datasource = ''};

	//constructor
	public any function init(required com.beans.datasource datasource) output="false" hint="I am the constructor for the BookDAO class" { 
		variables.instance.datasource = arguments.datasource;
		return this;
	}	

	//public methods

	public boolean function saveBook(required com.beans.book book) output="false" hint="I save the supplied book by saving a new entry or updating an existing one" {
		var success = '';
		if (exists(arguments.book)) {
			success = updateBook(arguments.book);
		} else {
			success = createNewBook(arguments.book);
		}
		return success;
	}

	public boolean function exists(required com.beans.book book) output="false" hint="I check if the supplied book exists in the database" {
		var result = '';
		var qExists = new Query(datasource=variables.instance.datasource.getDSName());
		qExists.setSQL("select count(1) as idExists from books where bookID = :bookID");
		qExists.addParam(name="bookID", type="cf_sql_integer", value=arguments.book.getBookID());
		result = qExists.execute().getResult();
		if (result.idExists) {
			return true;
		} else {
			return false;
		}
	}

	private boolean function createNewBook(required com.beans.book book) output="false" hint="I enter a new book to the database" {
		var insertResult = 0;
		var result = '';
		var qCreate = new Query(datasource=variables.instance.datasource.getDSName());
		qCreate.setSQL("insert into books(bookName,bookSeries,bookSequence,havePaperBook,haveEBook) values ( :bookName , :bookSeries , :bookSequence , :havePaperBook , :haveEBook )");
		qCreate.addParam(name="bookName", type="cf_sql_varchar", value=arguments.book.getbookName());
		qCreate.addParam(name="bookSeries", type="cf_sql_integer", value=arguments.book.getBookSeries());
		qCreate.addParam(name="bookSequence", type="cf_sql_integer", value=arguments.book.getBookSequence());
		qCreate.addParam(name="havePaperBook", type="cf_sql_varchar", value=arguments.book.getHavePaperBook());
		qCreate.addParam(name="haveEBook", type="cf_sql_varchar", value=arguments.book.getHaveEBook());
		try {
			result = qCreate.execute();
			if (result.getPrefix().generatedKey) {
				insertResult = true;
			} else {
				insertResult = false;
			}
			}	catch (any e) {
				insertResult = false;
			}	
		return insertResult;
	}

	public any function getBookByID(required numeric bookID="0") output="false" hint="I return a bean populated by a book " {
		var qRead = new Query(datasource=variables.instance.datasource.getDSName());
		var objBook ='';
		var result = '';
		var bookData = '';
		qRead.setSQL("select bookID, bookName, bookSeries, seriesName, bookSequence, havePaperBook, haveEBook from books left join series on books.bookSeries = series.seriesID where bookID = :bookID");
		qRead.addParam(name="bookID", type="cf_sql_integer", value=arguments.bookID);
		result=qRead.execute();
		bookData=result.getResult();
		if (bookData.recordcount) {
				objBook = createObject('component','com.beans.book').init(bookID=bookData.bookID,bookName=bookData.bookName,seriesName=bookData.seriesName,bookSeries=bookData.bookSeries,bookSequence=bookData.bookSequence,havePaperBook=bookData.havePaperBook,haveEBook=bookData.haveEBook);
			} else {
				objBook = createObject('component','com.beans.book').init();
			}
		return objBook;
	}

	private boolean function updateBook(required com.beans.book book) output="false" hint="I update a books details" {
		var qUpdate = new Query(datasource=variables.instance.datasource.getDSName());
		var outcome = true;
		try {
				qUpdate.setSQL("update books set bookName = :bookName, bookSeries = :bookSeries, bookSequence = :bookSequence, havePaperBook = :havePaperBook, haveEBook = :haveEBook where bookID = :bookID");
				qUpdate.addParam(name="bookName", type="cf_sql_varchar", value=arguments.book.getBookName());
				qUpdate.addParam(name="bookSeries", type="cf_sql_integer", value=arguments.book.getBookSeries());
				qUpdate.addParam(name="bookSequence", type="cf_sql_integer", value=arguments.book.getBookSequence());
				qUpdate.addParam(name="havePaperBook", type="cf_sql_varchar", value=arguments.book.getHavePaperBook());
				qUpdate.addParam(name="haveEBook", type="cf_sql_varchar", value=arguments.book.getHaveEBook());
				qUpdate.addParam(name="bookID", type="cf_sql_integer", value=arguments.book.getBookID());
				qUpdate.execute();
			} catch (any e) {
				outcome = false;
		}
		return outcome;
	}

	public boolean function deleteBookByID(required numeric bookID) output="false" hint="I delete the selected book from the database" {
		var qDelete = new Query(datasource=variables.instance.datasource.getDSName());
		var outcome = true;
		try {
				qDelete.setSQL("delete from books where bookID = :bookID");
				qDelete.addParam(name="bookID", type="cf_sql_integer", value=arguments.bookID);
				qDelete.execute();
			} catch (any e) {
				outcome = false;
			}
		return outcome;
	}

}

