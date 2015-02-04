<cfcomponent>
	

	<cfset this.clientManagement = "true" >
	<cfset this.cache.useInternalQueryCache = "true" >

	<cfset this.datasource="cfartgallery">
	<cfscript>
		
		this.name = "hello";
		this.cache.querysize = 100;
		this.authcookie.disableupdate = true;
		    	    
    </cfscript>

</cfcomponent>

