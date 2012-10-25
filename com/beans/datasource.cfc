component displayName="datasource" output="false" hint="I am the datasource class" {

	//properties
	property name="DSName" type="string" default=""; 

	//pseudo constructor
	variables.instance = {DSName = ""};

	//constructor
	public any function init(required string DSName) output="false" hint="I am the constructor for the datasource class" {
		variables.instance.DSName = arguments.DSName;
		return this;
	}

	//getters
	public any function getDSName() output="false" hint="I return the name of the datasource" {
		return variables.instance.DSName;
	}

}