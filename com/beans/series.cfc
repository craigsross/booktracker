/**
*  
* @file  /home/craig/workspace/bookTracker2/com/beans/series.cfc
* @author  Craig Ross
* @description I am the series class
*
*/

component output="false" displayname="series"  {
	
	//properties
	property name="seriesID" type="numeric" default="0";
	property name="seriesName" type="string" default="";
	property name="seriesAuthor" type="numeric" default="0";

	//pseudo constructor
	variables.instance = {seriesID='0', seriesName='', seriesAuthor='0'};

	//constructor 
	public any function init(numeric seriesID='0', string seriesName='', numeric seriesAuthor='') output="false" hint="I am the constructor for the series class" { 
		setSeriesID(arguments.seriesID);
		setSeriesName(arguments.seriesName);
		setSeriesAuthor(arguments.seriesAuthor);
		return this;
	}	

	//setters

	private void function setSeriesID(required numeric seriesID='0') output="false" hint="I set the series ID" {
		variables.instance.seriesID = arguments.seriesID;
	}

	private void function setSeriesName(required string seriesName='') output="false" hint="I set the series Name" {
		variables.instance.seriesName = arguments.seriesName;
	}
	

	private void function setSeriesAuthor(required numeric seriesAuthor='') output="false" hint="I set the series author" {
		variables.instance.seriesAuthor = arguments.seriesAuthor;
	}
	
	//getters

	public numeric function getSeriesID() output="false" hint="I return the series ID" {
		return variables.instance.seriesID;
	}

	public string function getSeriesName() output="false" hint="I return the series Name" {
		return variables.instance.seriesName;
	}

	public numeric function getSeriesAuthor() output="false" hint="I return the series author" {
		return variables.instance.seriesAuthor;
	}
	
}