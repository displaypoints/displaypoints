// jQuery comboselect plugin
// version 1.0.2
// (c)2008 Jason Huck
// http://devblog.jasonhuck.com/
//
// Transforms a single select element into a pair of multi-selects
// with controls to move items left to right and vice versa. Keeps
// items sorted alphabetically in both lists (if desired). Selected
// items are submitted by the original form element. Double-clicking 
// moves an item from one side to the other.
//
// Written against jQuery 1.2.3, but older versions may work.
//
// Requires the jQuery Selso plugin:
// http://plugins.jquery.com/project/selso
// 
// Usage: $('#myselect').comboselect({
// 		sort: [string,'none'|'left'|'right'|default:'both'],	// which sides to sort
// 		addbtn: [string,default:' &gt; '], 						// label for the "add" button
// 		rembtn: [string,default:' &lt; ']						// label for the "remove" button
// });
//
// Version History
// 1.0.2	Now works correctly if the form is not the immediate parent of the select.
//			Clears originally selected options before updating with user's new selections on submit.
//			Correctly transforms selects whose options were added dynamically. 
// 1.0.1	Correctly transforms inputs which already had options selected.
// 1.0.0	Initial release.


(function($){
	jQuery.fn.comboselect = function(settings){
		settings = jQuery.extend({
			sort: 'both',		// which sides to sort: none, left, right, or both
			addbtn: ' &gt; ',	// text of the "add" button
			rembtn: ' &lt; '	// text of the "remove" button
		}, settings);
		this.each(function(){
			var selectID = this.id;
			var leftID = selectID + '_left';
			var rightID = selectID + '_right';
			var theForm = $(this).parents('form');
			var combo = '';
			$(this).find('option').each(function(){ 
			  this.id = $(this).attr('value')
			})
			var opts = $(this).html()
			combo = ' \
			  <fieldset class="comboselect"> \
			    <select id="' + leftID + '" name="' + leftID + '" class="csleft" multiple="multiple">'+opts+'</select> \
			    <fieldset> \
			      <input type="button" class="csadd" value="' + settings.addbtn + '" /> \
			      <input type="button" class="csremove" value="' + settings.rembtn + '" /> \
			    </fieldset> \
			    <select id="' + rightID + '" name="' + rightID + '" class="csright" multiple="multiple"></select> \
			  </fieldset>';		
			$(this).hide().after(combo);
			sortBoxes(leftID,rightID)
      $(this).trigger('comboselect.complete');
      theForm.submit(function(){
				$('#' + selectID).find('option:selected').removeAttr('selected');	
				$('#' + rightID).find('option').each(function(){
					var v = $(this).attr('value');
					$('#' + selectID).find('option[value="' + v + '"]').attr('selected','selected');
				});
				return true;
			});      	
		});

		// double-click moves an item to the other list
		$('select.csleft').dblclick(function(){
			$(this).parent().find('fieldset input.csadd').click();
		});
		
		$('select.csright').dblclick(function(){
			$(this).parent().find('fieldset input.csremove').click();
		});

		// add/remove buttons
		$('input.csadd').click(function(){
			var left = $(this).parent().parent().find('select.csleft');
			var leftOpts = $(this).parent().parent().find('select.csleft option:selected');
			var right = $(this).parent().parent().find('select.csright');
			right.append(leftOpts);
			right.trigger('comboselect.add', [leftOpts])
			sortBoxes(left.attr('id'), right.attr('id'));
		});
	
		$('input.csremove').click(function(){
			var left = $(this).parent().parent().find('select.csleft');
			var right = $(this).parent().parent().find('select.csright');
			var rightOpts = $(this).parent().parent().find('select.csright option:selected');
			left.append(rightOpts);
			right.trigger('comboselect.remove', [rightOpts])
			sortBoxes(left.attr('id'), right.attr('id'));
		});			

		function sortBoxes(leftID, rightID){
			switch(settings.sort){
				case 'none': var toSort = null;
				case 'left': var toSort = $('#' + leftID); break;
				case 'right': var toSort = $('#' + rightID); break;
				default: var toSort = $('#' + leftID + ', #' + rightID);					
			}
			if(settings.sort != 'none'){
				toSort.find('option').selso({
					type: 'alpha', 
					extract: function(o){ return $(o).text(); } 
				});
			}
			$('#' + leftID + ', #' + rightID).find('option:selected').removeAttr('selected');
		}					
		$('input.csadd').click();
		return this;
	};	
	
})(jQuery);
