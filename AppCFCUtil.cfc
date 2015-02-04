<cfcomponent initmethod="init" >
	
	<cfset this.properties = structnew() >
	<cfset this.actualSettings = arrayNew(1) >
	<cfset filePath =  "#expandPath('.')#/appsettings.properties" >		

	<cfloop file="#filePath#" index="line" >
		<cfset parseproperties(line) >
	</cfloop>
	
	<cfset this.Keys = structkeyarray(this.properties)>
	<cfset arraysort(this.keys,"textnocase","asc")>
	
	<cffunction name="readAppCFC" returntype="array" >
		
		<cfset filePath =  "#expandPath('../')#/Application.cfc" >
		<cfset settings = arraynew(1)>
		
		<cfset index = 1>
		<cfset lineNumber = 1>
		
		<cfloop file="#filePath#" index="line" >
			
			<cfset setting = getAppSetting(line) >
			
			<!--- continue if there is valid application setting defined on this line --->
			<cfif setting neq ""  >
				
				<cfset item = structnew() >
				<cfset item.code = line >
				<cfset item.explicit  = true >
				<cfset item.property = setting >
				<cfset item.lineNumber = lineNumber >
				
				<cfset settings[index] = item >				
				<cfset index++>
				
			</cfif>
			<cfset linenumber++ >
			
		</cfloop>
		
		<cfset var retArray = arrayNew(1) >
		<cfset var index = 1>
		
		<cfloop array="#this.Keys#" index="i">
			
			<cfscript>
				var retStruct = structnew();
				
				retStruct.property = i;
				retStruct.explicit = false;
				var propStruct = structfind(this.properties,i);
				retStruct.type = propstruct.type;
				retStruct.default = propStruct.default;
				retstruct.code = "";
				retstruct.lineNumber = -1;
				retstruct.value = ""; 
            	            
            	for(var j=1; j <= arrayLen(settings); j++)
            	{
            		if(findNoCase(settings[j].property, i) > 0)
            		{
            			retStruct.explicit = true;
            			retstruct.code = settings[j].code;
            			retstruct.lineNumber = settings[j].lineNumber;
            			retStruct.value = parseValue(trim(retstruct.code));
            		}
            	}
            	
            	retarray[index] = retstruct;            	
            	index++;
            </cfscript>
			
		</cfloop>
	<cfcache action="put" id="appadmin.actualSettings" value="#retArray#" region="Object">
	<cfreturn retarray>
		
	</cffunction>
	
	<cffunction name="writeAppCFC" returntype="void" >
		<cfargument name="setProperties" type="struct" >
		
		<cfset var changedProps = structnew() >
		<cfset var actualSettings = cacheGet("appadmin.actualSettings","Object") >

		<!--- identify which settings have changed --->
		<cfloop array="#actualSettings#" index="i">
			
			<cfscript>
				
				if(structkeyExists(setproperties,i.property))
				{
					var item = duplicate(i);
					var newVal = structfind(setproperties,i.property);
					
					if(item.value != newVal)
					{
						if(item.type != "boolean")
						{
							item.value =  newVal;
							structinsert(changedProps,i.property,item);
						}
						else if(item.value == "" || item.value == "false")
						{
							item.value = "true";
							structinsert(changedProps,i.property,item);
						}
						
					}
				}
				else
				{
					//checkbox unchecked in UI so no setting present in form
					if(i.type == "boolean")
					{
						var item = duplicate(i);
						if(item.value == "true")
						{
							item.value =  false;
							structinsert(changedProps,i.property,item);
						}
					}
				}
            	            
            </cfscript>
			
		</cfloop>
		<cfset persistChangedSettingsToFile(changedProps) >
	</cffunction>
	
<cffunction name="persistChangedSettingsToFile" returntype="void" >
	<cfargument name="changedProps" type="struct" >
	
	
	<cfset var filePath =  "#expandPath('../')#/Application.cfc" >
	<cfset var settings = arraynew(1)>
		
		<cfset var index = 1>
		<cfset var lineNumber = 1>
		<cfset var appCode = "">
		<cfset var firstSettingLineNumber = -1 >
		<cfloop file="#filePath#" index="line" >
			
			<cfset var lineKey =  getAppSetting(line) >
			
			<cfif lineKey neq "" and firstSettingLineNumber eq -1 >
				<cfset appCode = appCode & chr(10) & chr(13) & "$$$" & chr(10) & chr(13)>
				<cfset firstSettingLineNumber = lineNumber>
			</cfif>
			
			
			<cfif structkeyExists(changedprops,linekey) >
				
				<cfset var item = structfind(changedprops,linekey) >
				<cfset var startIndex = -1>
				<cfif isTagStyle(line)>
					
					<cfset startIndex = find("<",line ) >

					<cfset line = left(line,startIndex-1) & '<cfset ' & item.property & ' = "' & item.value & '" >' >
				<cfelse>
					<cfset startIndex = find("this",line ) >
					<cfset line = left(line,startIndex-1) & item.property & ' = "' & item.value & '" ;' >
				</cfif>
				<cfset structdelete(changedProps,item.property) >
			</cfif>
			
			
			<cfset var newLine = "" & chr(10) & chr(13) >
			<cfif trim(line) neq "" >
				<cfset newline = "" & chr(10) & chr(13) >
			</cfif>
			<!---<cfoutput ><pre>|#line# #newLine#$</pre></cfoutput>--->
			<cfset appcode = appCode & line & newLine  >
			
			
			<cfset linenumber++ >
			
		</cfloop>

		<cfset appCode = addNewProperties(appcode, changedProps) >
		<cfset backupAndWriteAppCFC(appcode) >
		
	
</cffunction>

<cffunction name="backupAndWriteAppCFC" access="private" >
	<cfargument name="code" type="string" >
	
	<cffile action="read" file="#expandPath('../')#/Application.cfc" variable="content">
	<cffile action="write" file="#expandPath('../')#/Application.bckp" output="#content#" >
	<cffile action="write" file="#expandPath('../')#/Application.cfc" output="#code#" >
	
</cffunction>

<cffunction name="addNewProperties" returntype="string" >
	<cfargument name="code" type="string" >
	<cfargument name="newProps" type="struct" >
	
	<cfset var keys = structkeyArray(newprops) >
	
	<cfset var compIndex = findNoCase("<cfcomponent>",code) >
	<cfset var tagStyle = false >
	<cfif compIndex gt 0 >
		<cfset tagStyle = true>
	</cfif>
	<cfset var newCode = "" >
	<cfloop array="#keys#" index="i">
		<cfset var item = structfind(newProps,i) >
		<cfif tagStyle>	
			<cfset line = '<cfset ' & item.property & ' = "' & item.value & '" >' >
		<cfelse>
			<cfset line = item.property & ' = "' & item.value & '" ;' >
		</cfif>
		<cfset newCode = newcode & chr(9) & line & chr(10) & chr(13)  >		
	</cfloop>
	
	<cfset code = replace(code,"$$$",newcode)>
	<cfreturn code>
	
</cffunction>
	
<cffunction name="parseValue" returntype="Any" >
	<cfargument name="code" type="string" >
	<cfset var endString = ">" >
	<cfset var startString = "<" >
	<cfset var index = find("=",code) >
	<cfif index gt 0>

		<cfif (right(code,len(endString)) eq endString) AND (left(code,len(startString)) eq startString)>
			<!--- tag style code --->
			<cfset valEndIndex =   find(">",code,index+1) >
			<cfset value = mid(code,index+1, valendIndex - (index+1))>				
		<cfelse>
			<!--- script style code --->
			<cfset valEndIndex =   find(";",code,index+1) >
			<cfset value = mid(code,index+1, valendIndex - (index+1))>					
		</cfif>
		
		<cfreturn trim(stripQuotes(trim(value)))>
		
	</cfif>
	<cfreturn "$">
</cffunction>
	
<cffunction name="stripQuotes" >
	<cfargument name="str" type="string" >
	
	<cfset searchChar = '"' >
	<cfif (right(str,len(searchChar)) eq searchChar) AND (left(str,len(searchChar)) eq searchChar)>
		<cfreturn mid(str,2,len(str)-2) >
	</cfif>
	<cfset searchChar = "'" >
	<cfif (right(str,len(searchChar)) eq searchChar) AND (left(str,len(searchChar)) eq searchChar)>
		<cfreturn mid(str,2,len(str)-2) >
	</cfif>
	
	<cfreturn str>
	
</cffunction>
	
	<!--- Return the particular Application setting present at given line --->
	<cffunction name="getAppSetting"  returntype="String" >
		<cfargument name="line" type="string" >
		
		<cfloop array="#this.keys#" index="i">
			
			<cfif findnoCase(i,line) gt 0 >
				<cfreturn i>
			</cfif>
			
		</cfloop>
		
		<cfreturn "">
		
	</cffunction>
	
	<cffunction name="parseProperties" >
		<cfargument name="lineStr" type="string" >
		
		<cfset equalsIndex =  find("=",linestr) >
		<cfif equalsIndex gt 0>
			<cfset var propertyName = left(lineStr,equalsIndex-1) >
			<cfset var propertyStr = mid(lineStr,equalsIndex+1,len(linestr))>
			
			<cfscript>
				
				var markerIndex = find("|",propertyStr);
				if(markerIndex > 0)
				{
					var propertyVal = left(propertyStr,markerIndex-1);
					var defaultVal = mid(propertyStr,markerIndex+1,len(propertyStr));
				}
				else
				{
					var propertyVal = propertyStr;
					var defaultVal = "";
				}
				
				var item = structNew();
				item.type = propertyVal;
				item.default = defaultVal;
            	            
            </cfscript>
			
			<cfset structinsert(this.properties,propertyName,item) >
		</cfif>
		
	</cffunction>
<cffunction name="isTagStyle" access="private" returntype="boolean" >
	<cfargument name="code" >	
	
	<cfset code = trim(code) >
	<cfset var endString = ">" >
	<cfset var startString = "<" >
	
	<cfif (right(code,len(endString)) eq endString) AND (left(code,len(startString)) eq startString)>
			<cfreturn true>			
						
	</cfif>
	
	<cfreturn false>
	
</cffunction>
	
</cfcomponent>