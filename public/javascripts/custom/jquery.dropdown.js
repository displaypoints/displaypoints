(function($){
	$.ui = $.ui || {}; $.ui.dropdown = $.ui.dropdown || {}; var active; var selected = -1; var size;
	$.ui.dropdown = {
		show: function(){
			$('ul.dropdown').each($.ui.dropdown.remove)
			var self = $(this)
			var offset = self.siblings('a').offset();
			var li = self.parents('li');
			if(offset == null){ offset = self.siblings('span').offset()}
			self.siblings('ul').clone().addClass('dropdown').appendTo('body')
				.css({top: offset.top + self.outerHeight(), left: offset.left}).show();
			li.addClass('active')
			size = $('ul.dropdown li').length
			$(document).one('click.dropdown',$.ui.dropdown.globalWatch)
			$(document).bind('keydown.dropdown',$.ui.dropdown.keyNav)
			$(this).bind('click.removeDropdown',$.ui.dropdown.remove)
			return false;
		},
		keyNav: function(e){
			if(e.which == 27) { $(document).trigger("click.dropdown"); }
			else if(e.which == 40 || e.which == 38) {
				switch(e.which) {
					case 40:
						selected = selected >= size - 1 ? 0 : selected + 1; break;
					case 38:
						selected = selected <= 0 ? size - 1 : selected - 1; break;
					default: break;
				}
				active = $("ul.dropdown li a").removeClass("hover").slice(selected, selected + 1).addClass("hover");
			}else if(e.which == 13){
				window.location = active[0].href 
			}else { return true; }
			$.data(document.body, "suppressKey", true);
		},
		remove: function(){
			$('ul.dropdown').remove();
			$('li.active a').unbind('click.removeDropdown')
			$('li.active').removeClass('active');
			$(document).unbind('keydown.dropdown')
		},
		globalWatch: function(){
			if(this != $('ul.dropdown')[0]){
				$.ui.dropdown.remove();
			}
		}
	}
	
	$.fn.dropdown = function(){
		$(this).find('a.dropdown').bind('click.revealDropdown',$.ui.dropdown.show);
	}
})(jQuery);