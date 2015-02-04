<cfcomponent>
	
	<cffunction name="getHTMLForType" returntype="string" >
		<cfargument name="setting" type="Struct" >
		
		<cfswitch expression="#lcase(setting.type)#" >
			
			<cfcase value="string" >
				
				<cfsavecontent variable="htmlCode" >
					<cfoutput><input type="text" value="#setting.value#" name="#setting.property#" /></cfoutput>
				</cfsavecontent>
				
				<cfreturn  htmlCode>
			</cfcase>
			<cfcase value="boolean" >
				
				<cfsavecontent variable="htmlCode" >
					<cfset checkStr = "">
					<cfif setting.explicit>
						<cfset checkStr = "checked" />
					</cfif>
					<cfoutput><input type="checkbox" #checkStr# name="#setting.property#" /></cfoutput>
				</cfsavecontent>
				
				<cfreturn  htmlCode>
				
			</cfcase>
			<cfcase value="integer" >
				
				<cfsavecontent variable="htmlCode" >
					<cfoutput><input type="text" value="#setting.value#" name="#setting.property#" /></cfoutput>
				</cfsavecontent>
				
				<cfreturn  htmlCode>
				
			</cfcase>
			
		</cfswitch>
		
	</cffunction>

	<cffunction name="getRow" returntype="string" >
		<cfargument name="setting" type="struct" >

		<cfsavecontent variable="htmlCode" >
			
			<cfoutput>
            	<tr>
		           <td align="left">#replace(setting.property,"this.","")#</td>
		           <td align="left">#getHTMLForType(setting)#</td>
		           <td align="center">#setting.explicit#</td>
		           <td align="center">#getDefault(setting.default)#</td>
		           <td align="center">#setting.type#</td>
		           
	    		</tr>

            </cfoutput>
			
		</cfsavecontent>
		
		<cfreturn htmlcode>
		
	</cffunction>
	
	<cffunction name="getDefault" returntype="string" >
		<cfargument name="val" type="string" >
		
		<cfset retVal = val>
		<cfif val eq "@">
			<cfset retval = "Administrator Value" >
		</cfif>
		<cfif val eq "">
			<cfset retval = "-" >
		</cfif>
		<cfreturn retval>
	</cffunction>
</cfcomponent>