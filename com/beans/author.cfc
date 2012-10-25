component displayName="authors" output="false" hint="I am the author class" {

	// properties
	property name="authorID" type="numeric" default="0";
	property name="authorFirstName" type="string" default="";
	property name="authorLastName" type="string" default="";

	// pseudo contstructor
	variables.instance = {authorID='',authorFirstName='',authorLastName=''};

	public any function init(required numeric authorID="0",required string authorFirstName="",required string authorLastName="") output="false" hint="I am the contstructor for the author class"{
		setAuthorID(arguments.authorID);
		setAuthorFirstName(arguments.authorFirstName);
		setAuthorLastName(arguments.authorLastName);
		return this;
	}

	//setters
	private void function setAuthorID(required numeric authorID="0") output="false" hint="I set the Author ID" {
		variables.instance.authorID=arguments.authorID;
	}

	private void function setAuthorFirstName(required string authorFirstName="") output="false" hint="I set the author first name" {
		variables.instance.authorFirstName=arguments.authorFirstName;
	}

	private void function setAuthorLastName(required string authorLastName="") output="false" hine="I set the author last name" {
		variables.instance.authorLastName=arguments.authorLastName;
	}

	//getters
	public numeric function getAuthorID() output="false" hint="I return the authors ID" {
		return variables.instance.authorID;
	}

	public string function getAuthorFirstName() output="false" hint="I return the authors first name" {
		return variables.instance.authorFirstName;
	}

	public string function getAuthorLastName() output="false" hint="I return the authors last name" {
		return variables.instance.authorLastName;
	}

	public string function getAuthorFullName() output="false" hint="I return the authors full name" {
		authorFullName = getAuthorFirstName() & ' ' & getAuthorLastName();
		return authorFullName;
	}

}