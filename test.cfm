<cfset obj = createobject("component","AppCFCUtil") >

<cfset settings =  obj.readAppCFC()>

<cfdump var="#settings#">

<!---<cfoutput>#parseValue('<cfset this.datasource="cfartgallery">')#</cfoutput><br/>
<cfoutput>#parseValue("<cfset this.datasource='cfartgallery'>")#</cfoutput><br/>
<cfoutput>#parseValue("<cfset this.datasource= 100 >")#</cfoutput><br/>
<cfoutput>#parseValue(" this.datasource='cfartgallery';")#</cfoutput><br/>
<cfoutput>#parseValue(' this.datasource="cfartgallery";')#</cfoutput><br/>
<cfoutput>#parseValue(" this.datasource= 100 ;")#</cfoutput><br/>

<cffunction name="parseValue" returntype="Any" >
		<cfargument name="code" type="string" >
		<cfset endString = ">" >
		<cfset startString = "<" >
		<cfset index = find("=",code) >
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
			
			<cfreturn trim(stripQuotes(value))>
			
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
	
</cffunction>--->