function enableCampaign(){
  $('a.hiddenSection').click(function(){
    var self = $(this);
    self.hide().siblings('.section').find('form').clearForm().end().show('blind', {direction: 'vertical'}, 500);
    return false;
  });
  $('.section a.cancel').click(function(){
    $(this).parents('.section').hide('blind', {direction: 'vertical', callback:function(){
      $(this).siblings('a.hiddenSection').show();
    }}, 500);
  });
  $('form.contentItem').ajaxForm({
    dataType: 'json',
    resetForm: true,
    success: addContentItem
  });
  $('form.publishGroup').ajaxForm({
    dataType: 'json',
    resetForm: true,
    success: addPublishGroup
  });
  $('ul.available.pages li').click(contentItemPages);
  $('select.comboselect')
      .bind('comboselect.complete', function(){ 
        var self = $(this);
        var parent = $(this).parents('.exclude, .include');
        if(parent.length > 0){
          if(this != parent.find('select:first')[0]){
            $(this).siblings('fieldset.comboselect').hide();
          }
        }
      })
    .comboselect({ sort: 'both', addbtn: '&raquo;',  rembtn: '&laquo;' });
  $('.pg label').click(function(){
    $(this).siblings('fieldset.comboselect').toggle('blind', { direction: 'vertical'}, 500);
  });
  dynamicGroups();
}

function contentItemPages(){
  var ids = [];
  var self = $(this);
  self.toggleClass('ci-selected');
  self.parent().find('.ci-selected').each(function(){
    ids.push(this.id.split('_')[1]);
  });
  self.parent().prev().val(ids.join(','));
  return false;
}

function addContentItem(data){
  var images = [];
  $.each(data.pages, function(i, val){
    images.push('<img src="'+val+'" />');
  });
  $('<div><h4>' + data.name + '</h4>'+ images +'</div>').appendTo('.contentItems');
  $('.section').hide('blind', {direction: 'vertical'}, 500);
}

function addPublishGroup(data){
  $('#campaign_publish_group_id_right')
    .append('<option value="'+data.id+'" id="'+data.id+'">'+data.name+'</option>');
  $('form.publishGroup').parent().hide('blind', {direction: 'vertical'});
  $('form.publishGroup').parent().siblings('a.hiddenSection').show();
}

function dynamicGroups(){
  $('.include select.csright').livequery(function(){
    $(this).bind('comboselect.add', addHandler).bind('comboselect.remove', removeHandler);
  });
  $('.exclude select.csright').livequery(function(){
    $(this).bind('comboselect.add', addHandler).bind('comboselect.remove', removeHandler);
  });
}

function addHandler(self,data){ comboHandler(self,data, true); }

function removeHandler(self,data){ comboHandler(self,data, false); }

function comboHandler(self,data,add){
  if(data.length == 0)
    return false;
  var opts = getOpts(self.target);
  if(add){
    //remove added option from exclude or include
    $.each(data, function(i, val){ $('.'+opts.klass+' select.csleft option#'+val.id).remove(); });
  }else{
    //add removed option to exclude or include
    $.each(data, function(i, val){ $('.'+opts.klass+' select.csleft').append($(val).clone()); });
  }
  next = $(self.target).parents('.pg').next();
  fetchKlass = (next) ? next.find('select:first')[0].id.match(/publish_group_((not_)?.+)_id/)[1] : null;
  if(opts.ids.length == 0){
    $('.'+opts.type+',.not_'+opts.type).next().find('.csleft, .csright').html('');
  }else{
    if(opts.klass.match(/not/)){
      $.ajax({
        url         : '/publish_groups.json', 
        data        : {type: opts.type, ids: opts.ids.join(',')},
        success     : addChildren,
        dataType    : 'json',
        type        : 'get',
        beforeSend  : function(){
          $(self.target).parent('div.comboselect').after('<img src="/images/loading.gif" class="loader" />');
        }
      });
    }
  }
}

function getOpts(elem){
  var type = elem.id.match(/publish_group_(not_)?(.+)_id/)[2];
  return {
    ids   : $(elem).selectedOpts(),
    type  : type,
    klass : elem.id.match(/not/) ? type : 'not_'+ type
  };
}

function addChildren(data){
  $('img.loader').remove();
  if(data.objects.length > 0){
    var options = $.map(data.objects,function(obj){
      return '<option value="'+obj.id+'" id="'+obj.id+'">'+obj.name+'</option>';
    });
    updateSelect(data.type, options);
  }
}

$.fn.selectedOpts = function(){
  return $.map($(this).find('option'),function(o){ return o.id;});
};

function updateSelect(klass, options){
  var parents = $('.'+klass+',.not_'+klass).next();
  var selects = parents.find('select.csleft');
  selects.each(function(){
    var self = $(this);
    var id = self.attr('id').match(/(.+)_left/)[1];
    $('#'+id).html('');
    $.each(options,function(i, val){ $('#'+id).append(val); });
    self.html('');
    var ids = self.siblings('.csright').selectedOpts();
    $.each(options, function(i, val){
      if(ids.indexOf($(val).attr('id')) == -1){ self.append(val);}
    });
    if(ids.length > 0){
      $.each(ids, function(i, val){
        if(self.siblings('.csleft').find('#'+val).length == 0){
          self.siblings('.csright').find('#'+val).remove();
        }
      });
    }
  });
  
  if(parents.find('fieldset.comboselect').is(':hidden')){
    parents.find('fieldset.comboselect').show('blind',{direction:'vertical'});
  }
}