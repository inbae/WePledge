<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.hubba.wepledge.view.*, java.util.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    
    <title>We Pledge Admin Console</title>
    <meta name="description" content="">
    <meta name="author" content="">
    
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href='http://fonts.googleapis.com/css?family=Ubuntu+Condensed|Ubuntu' rel='stylesheet' type='text/css'>   
    <link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow' rel='stylesheet' type='text/css'>
    
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory: mathiasbynens.be/notes/touch-icons -->
    
    <!-- CSS: implied media=all -->
    <link rel="stylesheet" href="/admin/css/table.css">
    <link rel="stylesheet" href="/admin/css/fullcalendar.css">
    <link rel="stylesheet" href="/admin/css/simplemodal.css">
    <link rel="stylesheet" href="/admin/css/jquery.gritter.css">
    <link rel="stylesheet" href="/admin/css/jquery.wysiwyg.css">
    <link rel="stylesheet" href="/admin/css/chosen.css">
    <link rel="stylesheet" href="/admin/css/jquery-ui-1.8.16.custom.css">
    <link rel="stylesheet" href="/admin/css/elfinder.min.css">
    <link rel="stylesheet" href="/admin/css/jqtransform.css">
    <link rel="stylesheet" href="/admin/css/style.css">
    <!-- end CSS-->
    
    <!-- CSS Media Queries for Standard Devices -->
    <!--[if !IE]><!-->
        <link rel="stylesheet" href="/admin/css/devices/smartphone.css" media="only screen and (min-width : 320px) and (max-width : 767px)">
        <link rel="stylesheet" href="/admin/css/devices/ipad.css" media="only screen and (min-width : 768px) and (max-width : 1024px)"> 
    <!--<![endif]-->
    
    <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
        
    <!-- All JavaScript at the bottom, except for Modernizr / Respond.
         Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries
         For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
    <script src="/admin/js/libs/modernizr-2.0.6.min.js"></script>
</head>

<body>
<style>
input {
	width:78px;
	border-style: none;
	background-color: #E6E6E6;
	margin: 1px;
	font-family: 'Ubuntu', sans-serif;
	color:#424242;
}
td{
	text-align: center;
}
</style>

    <div id="body-container">
        <div id="container">
	        <header>
	            <a id="logo"></a>
				<div id="main-navigation">
            	    <ul>
            	        <li><a id="elements-m" href="/admin/campaigns"><span title="Elements area" class="files-32">Campaigns</span></a></li>
            	        <li><a id="forms-m" href="#" class="active"><span title="Forms area" class="users-32">Accounts</span></a></li>
           	     	</ul>
           		</div>
	            <div id="profile">
	                <div id="user-data">Welcome<br />${currentUser.email}</div>
	                <div><a href="/admin/logout">Logout</a></div>
	            </div>
	            <div class="clearfix"></div>
	        </header>
	        <div id="main" role="main">
	        
	            <div id="main-container">
	            
<div id="body-section">
	<div id="left-menu">
		<ul>
			<li class="menu-trigger active"><a href="#" class="data-16" id="c-overview">Overview</a></li>
			<li class="menu-trigger"><a href="#" class="data-16" id="c-addnew">Add New</a></li>
		</ul>
		<div class="clearfix"></div>
	</div>
	<div id="content-container">
		<div id="content">

			<div class="c-overview">			
				<div class="box-element">
					<div class="box-head-light box-head-icon forms-16">Accounts</div>
					<div class="box-content">
						<table cellpadding="0" cellspacing="0" border="0" class="display" id="datatable">
							<thead>
								<tr>
									<th>Email</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${users}">
								<tr>
									<td>${user.email}</td>
									<td><form action="/admin/deleteUser?userId=${user.id}" method="post"><input type="submit" value="Delete" name="delete"/></form></td>
								</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<th>Email</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
						<div class="clearfix"></div>
					</div>
				</div>											
			</div>
					

			<div class="c-addnew">			
				<div class="box-element">
					<div class="box-head-light box-head-icon forms-16">Add New User</div>
<div class="box-content no-padding">
						<form class="i-validate" action="/admin/addUser" method="post" novalidate="novalidate"> 
                            <fieldset>
                                <section>
                                    <div class="section-left-s">
                                        <label for="text_field">Login</label>
                                    </div>                                  
                                    <div class="section-right">
                                        <div class="section-input"><input type="text" placeholder="example@email.com" class="i-text required" id="text_field" name="email" value=""></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </section> 
                                <section>
                                    <div class="section-left-s">
                                        <label for="text_field">Password</label>
                                    </div>                                  
                                    <div class="section-right">
                                        <div class="section-input"><input type="password" class="i-text required" id="text_field" name="password" value=""></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </section>
                                <section>
                                    <div class="section-left-s">
                                        <label for="text_field">Confirm Password</label>
                                    </div>                                  
                                    <div class="section-right">
                                        <div class="section-input"><input type="password" class="i-text required" id="text_field" name="confirmpassword"></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </section>

								<c:if test="${addUserErrors!=null}">
									<% if (ViewUtils.hasError("addUserErrors", AddUserErrors.BLANK_EMAIL)) { %>
										<section>
											Blank Email
										</section>
									<% } %>
									<% if (ViewUtils.hasError("addUserErrors", AddUserErrors.INVALID_EMAIL)) { %>
										<section>
											Invalid Email
										</section>
									<% } %>
									<% if (ViewUtils.hasError("addUserErrors", AddUserErrors.BLANK_PASSWORD)) { %>
										<section>
											Password is blank
										</section>
									<% } %>
									<% if (ViewUtils.hasError("addUserErrors", AddUserErrors.NONMATCHING_PASSWORDS)) { %>
										<section>
											Password and Confirm Password do not match
										</section>
									<% } %>
									<% if (ViewUtils.hasError("addUserErrors", AddUserErrors.EMAIL_IN_USE)) { %>
										<section>
											Email already in use
										</section>
									<% } %>
								</c:if>
                                <section>
                                    <input type="submit" value="Submit" class="i-button no-margin" id="" name="submit">
                                    <div class="clearfix"></div>
                                </section>
                            </fieldset>
                        </form>
					</div>
				</div>
			</div>


			
		</div>
	</div>
	<div class="clearfix"></div>
</div>
					
					
	            </div> <!--! end of #main-container -->
	        </div>
	        <footer>
	            <span>We Pledge by <a href="http://www.hackforacause.org">HackForACause</a></span>
	        </footer>
	    </div> <!--! end of #container -->
   
    </div> <!--! end of #body-container -->
     
    <!-- JavaScript at the bottom for fast page loading -->
    <!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/admin/js/mylibs/excanvas.min.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="/admin/js/libs/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/libs/jquery-ui-1.8.16.custom.min.js"></script>
    
    <!-- scripts -->
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/elfinder.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.flot.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.flot.pie.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.flot.resize.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.flot.stack.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.flot.crosshair.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.dataTables.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.tools.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/fullcalendar.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.gritter.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.simplemodal.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.autogrowtextarea.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.wysiwyg.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/controls/wysiwyg.image.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/controls/wysiwyg.link.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/controls/wysiwyg.table.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.idTabs.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.validate.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/chosen.jquery.min.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.jqtransform.js"></script>
    <script language="javascript" type="text/javascript" src="/admin/js/mylibs/jquery.ba-hashchange.min.js"></script>
    <script defer src="/admin/js/init.js"></script>
    <script defer src="/admin/js/bootstrap.js"></script>
   	
    <!-- end scripts-->
    
    <!-- Prompt IE 6 users to install Chrome Frame. Remove this if you want to support IE 6.
         chromium.org/developers/how-tos/chrome-frame-getting-started -->
    <!--[if lt IE 7 ]>
      <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
      <script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
    <![endif]-->
  
</body>
</html>
