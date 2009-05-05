$(document).ready(addBehavior);

function addBehavior(){
  if($('#form_builder').length > 0){
    $.getScript('/javascripts/plugins/ui.spinner.js', function(){
      $.getScript('/javascripts/custom/form_builder.js', function(){
        formBuilder();
      });
    });
  }else if($('#links').length > 0){
    $.getScript('/javascripts/custom/cropper.js', function(){
      $.getScript('/javascripts/custom/page.js', function(){
        linkEditor();
      });
    });
  }else if($('#analyticsGraph').length > 0){
    $.getScript('/javascripts/custom/analytics.js', function(){
      enableAnalytics();
    });
  }else if($('#campaignBuilder').length > 0){
    $.getScript('/javascripts/custom/campaign.js', function(){
      enableCampaign();
    });
  }else if($('#newContract').length > 0){
    $.getScript('/javascripts/plugins/jquery.timepickr.js', dateSelection);
  }
  $('ul.tabs').tabs();
  $('ul.library li img').selectables();
  $.tablesorter.defaults.widgets = ['zebra', 'cookie','columnHighlight']; 
  var tables = '#tableAssets, #tableCampaigns, #tableContracts, #tablePublishGroups, \
    #tableCorporations, #tableUsers, #tableVenues';
  $(tables).each(function(){
    var self = $(this);
    self.tablesorter();
    self.tableSearch();
  });
}

function dateSelection(){
  $('.calendar div').datepicker({
    dateFormat: 'mm/dd/yy',
    onSelect: function(date){ $(this).siblings('input:hidden').val(date);}
  });
  // $('.time input.text').timepickr({dropslide:{trigger:'focus', top:20}});
}

$.fn.selectables = function(){
  this.click(function(){
    var li = $(this).parent();
    li.addClass('selected').siblings().removeClass('selected');
    li.parent().siblings('input:hidden').val(li.attr('id').split('_')[1]);
    return false;
  });
};

$.fn.blindAndRemove = function(func){
  $(this).hide('blind', {direction: 'vertical', callback: function(){
      if(func != null){
        func.call(this);
      }else{
        $(this).remove();
      } 
    }
  });
};