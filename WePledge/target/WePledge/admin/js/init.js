/* charts colors */
var i_gcolor = '2e7bb8', i_color = '#aaaaa', i_grid = { color:i_color, borderWidth:1 };
var i_options = {
		grid: i_grid,
		yaxis: { color:i_color },
		xaxis: { color:i_color}
	};

initFirstTime = function() {
	
	var hash = location.hash;
	
	$(window).hashchange( function(){
		if (hash == '#404' || hash == '#500') {
			loadBase(false);
		} else {
			gateway(location.hash);
		}
		hash = location.hash;
	});

	/* global notifications */
	$('#add-notify').click(function(){
		$.gritter.add({
			// (string | mandatory) the heading of the notification
			title: 'This is a regular notice!',
			// (string | mandatory) the text inside the notification
			text: 'This will fade out after a certain amount of time. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" style="color:#ccc">magnis dis parturient</a> montes, nascetur ridiculus mus.',
			// (bool | optional) if you want it to fade out on its own or just sit there
			sticky: false,
			// (int | optional) the time you want it to be alive for before fading out
			time: ''
		});
		return false;
	});

};

initTooltips = function() {
	
	$(".tt-center-left").tooltip({
		// place tooltip on the bottom
		position: "center left",
		// a little tweaking of the position
		offset: [0, -2]
	});		

	$(".tt-center-right").tooltip({
		// place tooltip on the bottom
		position: "center right",
		// a little tweaking of the position
		offset: [0, 2]
	});		

	$(".tt-top-center").tooltip({
		// place tooltip on the bottom
		position: "top center",
		// a little tweaking of the position
		offset: [-2, 0]
	});		

	$(".tt-bottom-center").tooltip({
		// place tooltip on the bottom
		position: "bottom center",
		// a little tweaking of the position
		offset: [2, 0]
	});
};
	
initCommon = function(){
		
	// main navigation actions
	$('#main-navigation ul li a').click(function(){
		if( !$(this).hasClass('active') ) {				
			var hash = $(this).attr('href');
		}
	});	
	
	var availableTags = [
		"ActionScript",
		"AppleScript",
		"Asp",
		"BASIC",
		"C",
		"C++",
		"Clojure",
		"COBOL",
		"ColdFusion",
		"Erlang",
		"Fortran",
		"Groovy",
		"Haskell",
		"Java",
		"JavaScript",
		"Lisp",
		"Perl",
		"PHP",
		"Python",
		"Ruby",
		"Scala",
		"Scheme"
	];
	$( "#search" ).autocomplete({
		source: availableTags
	});		

	/* box container */
	$(".collapsable").click(function (){
		if ($(this).is('.closed')) {
			$(this).removeClass('closed');
			$(this).addClass('open');
		} else {
			$(this).removeClass('open');
			$(this).addClass('closed');
		}
		$(this).closest('.box-element').find('.box-content').slideToggle();
		return false;
	});		
	
	/* modal popup */
	$('#show-modal').click(function(){
		$('#modal-content').modal({onShow: function(dlg) {
		    $(dlg.container).css('height','auto')
		}});
	});
	initTooltips();
	initElements();
	initForms();
	
};

// left menu init
initMenu = function(){

	//Set default open/close settings
	$('.menu-trigger:first').addClass('active').next().show(); //Add "active" class to first trigger, then show/open the immediate next container
	
	$('#content').children().each(function(){
		if (!$(this).is(':first-child')) {
			$(this).css('display', 'none');
		}
	});
	
	//On Click
	$('.menu-trigger').click(function(){
		if( !$(this).hasClass('active') ) { //If immediate next container is closed...
			$('.menu-trigger').removeClass('active');
			$(this).toggleClass('active');			
		}
		$('#content').children().each(function() { 
			$(this).css('display', 'none');
		});
		var clsname = $(this).children("a").attr("id");
		$("." + clsname).fadeIn();
		return false; //Prevent the browser jump to the link anchor
	});
};


initElements = function() {		
	/* alert boxes */
	$('.alert-msg a').click(function(){
		$(this).parent().fadeOut();
		return false;
	});
	
	/* tabs init */
	$("ul.tab-list").idTabs();
	
	$('#accordion').accordion({ 
	    autoHeight: false 
	});
	
	/* datagrid table */
	$('#datatable').dataTable({
		"sPaginationType": "full_numbers"
	});
};

initData = function() {		
	/* datagrid table */		
	$('#datatable').dataTable({
		"sPaginationType": "full_numbers"
	});
};


initFile = function() {		
	/* file manager */
	var elf = $('#elfinder').elfinder({
		// lang: 'ru',             // language (OPTIONAL)
		url : 'php/connector.php'  // connector URL (REQUIRED)
	}).elfinder('instance');
};

initForms = function() {		
	/* autogrow textarea */
	$(".i-textarea-auto").autoGrow();
	
	/* WYSIWYG editor */
	$('.i-editor').wysiwyg();
	
	$("form.i-validate").validate();
	$(".i-select").chosen();
	$(".i-datepicker").datepicker();
	
	$('.i-transform').jqTransform();
	
	$(".i-form-tooltip").tooltip({
		position: "center right",
		offset: [0, 5]
	});
};

