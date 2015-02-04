<form action="index.cfm" method="post" >

     <table width="100%" style="outline: thick solid #808080;" cellpadding="5"  >
       <tbody >
       	<tr style="outline: thin solid #808080;" ><td colspan="5" align="left"><input type="submit" value="Submit" name="submit" /></td></tr>
         <tr  >
           <th scope="col" align="left">Variable</th>
           <th scope="col">Value</th>
           <th scope="col">Explicit</th>
           <th scope="col">Default</th>
           <th scope="col">Type</th>
         </tr>
         
<cfset obj = createobject("component","AppCFCUtil") >
<cfset uiUtil = createobject("component","ui_util" ) >
<cfset settings =  obj.readAppCFC()>

<cfloop array="#settings#" index="i">
	<cfoutput>#uiUtil.getRow(i)#</cfoutput>			
</cfloop>
<tr style="outline: thin solid #808080;"><td colspan="5" align="left"><input type="submit" value="Submit" name="submit" /></td></tr>
       </tbody>
     </table>
     <h2>&nbsp;</h2>

</form>