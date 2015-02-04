
<cfoutput>

<html>

<head>

	<!--- ebk (trilemetry) 8/28/04 - added styles.css  --->

	<cfinclude template="/CFIDE/administrator/styles.cfm">

	<link rel="SHORTCUT ICON" href="#protocol##cgi.server_name#:#cgi.server_port##getContextRoot()#/CFIDE/administrator/favicon.ico">

</head>

<body style="background:##ececec">

<table width="100%" border="0" cellspacing="0" cellpadding="0">



<!--- start spacer row to make sure that all content never goes below 540 pixels wide even w window resize --->

<tr>

	<td><img src="#request.thisURL#images/contentframetopleft.png" alt="" height="23" width="16"></td>
	<td background="#request.thisURL#images/contentframetopbackground.png">
		<img src="#request.thisURL#images/spacer.gif" alt="" height="23" width="540">
	</td>
	<td><img src="#request.thisURL#images/contentframetopright.png" alt="" height="23" width="16"></td>

</tr>

<!--- end spacer row to make sure that all content never goes below 540 pixels wide even w window resize --->

  <tr>

	<!-----------------------------------------------------------------

	START SPACER CELL - so that there's some gray on the left

	------------------------------------------------------------------>

    <td width="16" style="background:url('#request.thisURL#images/contentframeleftbackground.png') repeat-y;">
    	<img src="#request.thisURL#images/spacer.gif" alt="" width="16" height="1">
    </td>

	<!-----------------------------------------------------------------

	END SPACER CELL - so that there's some gray on the left

	------------------------------------------------------------------>

	<td>

		<!-----------------------------------------------------------------

		START WHITE CAP TOP

		------------------------------------------------------------------>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">

		  <tr>

			<td width="12"><img src="#request.thisURL#images/cap_content_white_main_top_left.gif" alt="" width="12" height="11"></td>

		    <td bgcolor="##FFFFFF"><img src="#request.thisURL#images/spacer_10_x_10.gif" width="10" alt="" height="10"></td>

			<td width="12"><img src="#request.thisURL#images/cap_content_white_main_top_right.gif" width="12" alt="" height="11"></td>

		  </tr>

		</table>

		<!-----------------------------------------------------------------

		END WHITE CAP TOP

		------------------------------------------------------------------>

		<!-----------------------------------------------------------------

		START WHITE BOX

		------------------------------------------------------------------>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">

		  <tr>

		    <td width="10" bgcolor="##FFFFFF"><img src="#request.thisURL#images/spacer_10_x_10.gif" alt="" width="10" height="10"></td>

			<td bgcolor="##FFFFFF">

				<!-----------------------------------------------------------------

				START MAIN CONTENT TABLE

				------------------------------------------------------------------>

				<table width="100%" border="0" cellspacing="0" cellpadding="5">

				  <tr valign="top">

					<td valign="top">



<!--- table is closed in footer.cfm --->



</cfoutput>