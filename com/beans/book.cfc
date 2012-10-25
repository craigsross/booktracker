/**
*  
* @file  /home/craig/workspace/bookTracker2/com/beans/book.cfc
* @author  Craig Ross
* @description The book bean for the booktracker application
*
*/

component output="false" displayname="book" hint="I am the book class" {
	
	//properties
	property name="bookID" type="numeric" default="0";
	property name="bookName" type="string" default="";
	property name="bookSeries" type="numeric" default="0";
	property name="seriesName" type="string" default="";
	property name="bookSequence" type="numeric" default="0";
	property name="havePaperBook" type="string" default="No";
	property name="haveEBook" type="string" default="No";

	//pseudo constructor
	variables.instance = {bookID='0', bookName='', bookSeries='0', seriesName="", bookSequence='0', havePaperBook='No', haveEBook='No'};

	//constructor
	public any function init(numeric bookID="0", string bookName="", numeric bookSeries="0", string seriesName="", numeric bookSequence="0", boolean havePaperBook="no", boolean haveEBook="no") output="false" hint="I am the constructor for the book class" { 
		setBookID(arguments.bookID);
		setBookName(arguments.bookName);
		setBookSeries(arguments.bookSeries);
		setSeriesName(arguments.seriesName);
		setBookSequence(arguments.bookSequence);
		setHavePaperBook(arguments.havePaperBook);
		setHaveEBook(arguments.haveEBook);
		return this;
	}

	//setters
	private void function setBookID(required numeric bookID="0") output="false" hint="I set the book ID" {
		variables.instance.bookID = arguments.bookID;
	}
	
	private void function setBookName(required string bookName="0") output="false" hint="I set the book name" {
		variables.instance.bookName = arguments.bookName;
	}
	
	private void function setBookSeries(required numeric bookSeries="0") output="false" hint="I set the book series" {
		variables.instance.bookSeries = arguments.bookSeries;
	}
	
	private void function setSeriesName(required string seriesName="") output="false" hint="I set the series Name" {
		variables.instance.seriesName = arguments.seriesName;
		}

	private void function setBookSequence(required numeric bookSequence="0") output="false" hint="I set the book sequencde" {
		variables.instance.bookSequence = arguments.bookSequence;
	}

	private void function setHavePaperBook(required boolean havePaperBook="false") output="false" hint="I set the have paper book" {
		variables.instance.havePaperBook = arguments.havePaperBook;
	}

	private void function setHaveEBook(required boolean haveEBook="false") output="false" hint="I set the value of have ebook" {
		variables.instance.haveEBook = arguments.haveEBook;
	}

	//getters
	public numeric function getBookID() output="false" hint="I return the value of the bookID" {
		return variables.instance.bookID;
	}

	public string function getBookName() output="false" hint="I return the value of the book name" {
		return variables.instance.bookName;
	}

	public numeric function getBookSeries() output="false" hint="I return the value of the book series" {
		return variables.instance.bookSeries;
	}

	public string function getSeriesName() output="false" hint="I return the name of the book series" {
		return variables.instance.seriesName;
	}

	public numeric function getBookSequence() output="false" hint="I return the value of the book sequence" {
		return variables.instance.bookSequence;
	}

	public boolean function getHavePaperBook() output="false" hint="I return the value of have paper book" {
		return variables.instance.havePaperBook;
	}

	public boolean function getHaveEBook() output="false" hint="I return the value of have E Book" {
		return variables.instance.haveEBook;
	}

}