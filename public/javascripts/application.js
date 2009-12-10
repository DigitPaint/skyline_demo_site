var Site;

Site = {
  init : function(){
    this.initializeTableHover();
  },
	// Add support for table hovers on table.listing
	// Also add row-wide click by taking the first link in the row,
	// and making it the url to go to when clicking on the whole row,
	initializeTableHover : function(parent){
		$$('table.listing tbody tr').each(function(tr){
			tr.addEvent("mouseenter",function(){ tr.addClass("hover"); });
			tr.addEvent("mouseleave",function(){ tr.removeClass("hover"); });
			// Add clicking support
			var links = tr.getElements("a");
			if(links.length >= 1){
			  tr.addClass("clickable");
				tr.addEvent("click",function(){
					window.location = links[0].getProperty("href");
				});
			}
		});
	}  
};

window.addEvent("domready", Site.init.bind(Site));