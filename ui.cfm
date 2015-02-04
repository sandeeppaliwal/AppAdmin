<!---<html>
<head>
<script src="/CFIDE/scripts/ajax/jquery/jquery.js"></script>		

</head>

<!--- Begin Output --->
<cfinclude template="header.cfm">
<!---<cfinclude template="../include/margintop.cfm">--->

<cfscript>
		adminobj=createObject("component", "CFIDE.adminapi.administrator");
</cfscript>
<h2 class="pageHeader"><admin:l10n id="update_pageheader">
Server Update &gt; Updates</admin:l10n>
</h2>
<br>
<cfform name="editForm" action="#CGI.Script_Name#" method="post">
	<input type="hidden" name="csrftoken" value="#getCSRFToken(request.updatetabkeyname)#">
</cfform>	--->
<cfset obj = createobject("component","AppCFCUtil") >
<cfset uiUtil = createobject("component","ui_util" ) >

<cfset settings =  obj.readAppCFC()>

<form>

	<table align="center" width="50%" height="50%">
		
		<cfloop array="#settings#" index="i">
			<tr>
			<td><cfoutput>#i.property# #i.type#</cfoutput></td>
			<td><cfoutput>#uiUtil.getHTMLForType(i.type)#</cfoutput></td>
			<td><cfoutput>#encodeForHTML(i.code)#</cfoutput></td>
			<td><cfoutput>#i.explicit#</cfoutput></td>
		</tr>
		</cfloop>
		
	</table>
</form>


<!---<cfinclude template="../include/marginbottom.cfm">--->
<!---</html>--->
