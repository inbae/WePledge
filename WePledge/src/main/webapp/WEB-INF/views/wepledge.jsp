<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <title>WePledge</title>
  
  <link href='css/reset.css' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Open+Sans:800' rel='stylesheet' type='text/css'>
  <link href='style.css' rel='stylesheet' type='text/css'>

  <script src="/script/jquery-1.7.1.min.js" type="text/javascript"></script>
  <script src="/script/jquery.json-2.2.min.js" type="text/javascript"></script>
  <script src="/script/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
  <script src="/swipe.js" type="text/javascript"></script>
  <script src="/plugins.js" type="text/javascript"></script>
  <script src="/script/dashboard.js" type="text/javascript"></script>
  <script src="/script/pledge.js" type="text/javascript"></script>
  <script src="/script/settings.js" type="text/javascript"></script>
  <script src="/script/tabs.js" type="text/javascript"></script>
  <meta content="authenticity_token" name="csrf-param" />
  <meta content="GlfkMpJkyjG2qIWBo/7HYxmeNfW9MXCCVwqqNN3p6vg=" name="csrf-token" />

  <meta charset="utf-8">

  <meta name="description" content="">
  <meta name="author" content="">

  <meta name="HandheldFriendly" content="True">
  <meta name="MobileOptimized" content="320">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">

  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/apple-touch-icon_h.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/apple-touch-icon_l.png">
  <link rel="apple-touch-icon-precomposed" href="/images/apple-touch-icon.png">
  <link rel="shortcut icon" href="/images/apple-touch-icon.png">
</head>
<body>


<style>
.top_image .title {
	position: absolute;
	left: 10px;
	bottom: 20px;
	font-weight: 800;
	color: #E4092D;
	font-family: Futura, "Trebuchet MS", Arial, sans-serif;
	font-size: 150%;
}
.dash .pledges_header {
	margin: 0 auto;
	font-weight: bold;
	font-size: 175%;
	text-align: center;
}
#settings .go-to-settings, #settings .go-to-pledge {
	display: block;
	background: url("/images/icon_settings-2.png") no-repeat;
	width: 25px;
	height: 25px;
	position: fixed;
	bottom: 10px;
	right: 15px;
}
.ui-textbox {
	width:92%;
	margin:3px 0 6px;
	font-size:20px;
	border:1px solid #ccc;
	border-radius:4px;
	box-shadow:inset 0 2px 4px #444;
}
#loader {
	display:none
}
.number {
	background: url('/images/numberback.png');
	background-repeat: no-repeat;
	height: 84px;
	width: 64px;
	text-align: center;
	display: inline-block;
	font: Arial, sans-serif;
}
#mapContainer {
	height: 300px; 
	width: 100%; 
}
</style>

	<header>
		<img src="css/img/logo.png" alt="WE DAY" class="logo" />
    </header>
 	<nav>
    	<ul id='tabSelector'>
    		<li><a href="#">PAST DONORS</a></li>
    		<li class="on"><a href="#">MAKE A PLEDGE</a></li>
    	</ul>
    </nav>
    
    <div id="gallery">

	    <div id='tabs'>
	      <ul style="background: white;">
			<li class="dash" style='display:none'>
				<div id="number_container" style="font-size:84px; font-weight:bold; color:white; padding-left: 30%;" class="clearfix"></div>
				<div class="pledges_header">Pledges Worldwide</div>
				<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
				<div id="mapContainer">
					<article style="text-align:center;">
						<p>Finding your location: <span id="status">checking...</span></p>
					</article>
				</div>
			</li>
	        <li class="pledge" style='display:block'>
				<div id="pledge">
				    <form accept-charset="UTF-8" action="/pledges" class="new_pledge" data-remote="true" id="new_pledge" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="GlfkMpJkyjG2qIWBo/7HYxmeNfW9MXCCVwqqNN3p6vg=" /></div>
				        <input id="pledge_lat" name="pledge[lat]" type="hidden" />
				        <input id="pledge_long" name="pledge[long]" type="hidden" />
				
				        <input id="pledge_campaign_id" name="pledge[campaign_id]" type="hidden" />
				        <input id="pledge_time" name="pledge[time]" type="hidden" />
				
						<p class="notice"></p>
						<p class="alert"></p>
				
						<div>
							<div style="text-align:center;"><img src="/images/free_the_children.png" width="200" id="ftc" /></div>
						</div>
				
				        <div class="form_fields" style="padding:15px 15px 0px 15px;">
				          <input id="pledge_full_name" name="pledge[full_name]" size="30" type="text" class="ui-textbox" placeholder="Your Name"/>
				          <input id="pledge_email" name="pledge[email]" size="30" type="email" class="ui-textbox" placeholder="Email address" />
				          <input id="pledge_amount" name="pledge[amount]" size="30" type="number" class="ui-textbox" placeholder="Amount" />
				        </div>
				        
						<div style="padding:0px 15px 30px 15px;">
							<a href="#" id="pledge-submit" class="button">Pledge</a>
						</div>
				        <div id="loader"><img src="/images/ajax-loader.gif" style="position: relative; left: 45%;" /></div>
					</form>  
				</div>
			</li>
	      </ul>
		</div>
    
    </div>

	<div class="settings">
		<article class="container">
			<div class="heading_message" style="padding-bottom:10px;">
			  Select a campaign to support. Donors will pledge to the selected campaign.
			</div>
			<form id="settings-form">
			<c:forEach var="charity" varStatus="charityStatus" items="${charities}">
				<div>
				  <input type="radio" id="${charity.id}" name="campaign" class="campaign_radio" data-id="${charity.id}">
				  <label for="${charity.id}">${charity.name}</label>
				</div>
			</c:forEach>
			</form>
		</article>
	</div>
	
	<div id="settings">
		<a href="#" class="go-to-settings"></a>
		<a href="#" class="go-to-pledge"></a>
	</div>
</div>

</body>
</html>