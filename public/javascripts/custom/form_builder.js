function formBuilder(){
  $('#survey_top_margin').spinner({
    max: ($('#page img.root').height() - $('ul.survey').height()),
    min: 0
  }).bind('spinchange', function(){
    $('#page .survey').css({'margin-top': parseInt($(this).val()) })
  })
  $('li.input a.edit').livequery('click', editElement)
  $('ul.survey').sortable({
    axis: 'y',
    opacity: 0.4,
    update: function(e, ui){
      $.ajax({
        type: "post",
        dataType: "json",
        data: { 'survey[inquiry_ids][]': getItemOrder(), _method: 'put'},
        url: $('form.margin').attr('action'),
        success: function(){
          // console.log('reordered!')
        }
      })
    }
  })
  $('.new_inputs a').click(newElement)
  $('form.margin').ajaxForm({
    dataType: 'json',
    success: function(data){
      var notice = $('<div class="notice">Position updated</div>')
      notice.insertBefore('form:first').show('blind', {direction: 'vertical'})
      setTimeout(function(){
        notice.blindAndRemove()
      },3000)
    }
  })
  $('form a.cancel').livequery('click', function(){
    $(this).parents('form:first').blindAndRemove();
    return false;
  })
  $('form a.new_choice').livequery('click', function(){
    var id = $(this).prev().attr('id').split('_')
    id[2] = parseInt(id[2]) + 1
    $(this).prev().clone().val('')
      .insertBefore(this).attr('id',id.join('_')).focus()
    return false;
  })
  $('li.input a.delete').livequery('click', deleteElement)
}
 
function getItemOrder(){
  return $.map($('ul.survey li'), function(val, i){
    return val.id.split('_')[1];
  })
}
 
function editElement(){
  var self = $(this).parent('li.input')
  var type = self.attr('class').split(' ')[0];
  var id = self.attr('id').split('_')[1];
  if($('.new_inputs').next().is('form')){
    $('.new_inputs').next().blindAndRemove()
  }
  var form = $($.html.new_element_form(type)).insertAfter('.new_inputs')
  switch(type){
    case 'radio':
      self.find('div').each(function(i, obj){
        var choice = $('input#inquiry_choices_'+(i+1))
        choice.val($(obj).text())
        if($(obj).parent().find(':last')[0] != obj){
          choice.clone().val('')
            .insertAfter(choice)
            .attr('id','inquiry_choices_'+(i+2)).focus()
        }
      });
    default:
      $('#inquiry_question').val(self.find('label').text())
  }
  form.find("input[type='submit']").val('Update')
  form
    .show('blind', {direction: 'vertical'})
    .ajaxForm({
      type: "post",
      dataType: "json",
      url: $('form.margin').attr('action').replace(/survey/,'inquiries/'+id),
      success: function(data){
        self.replaceWith($.html.new_input_element(data))
        form.blindAndRemove();
      }
    })
  return false;
}
 
function newElement(){
  if($(this).parent().next().is('form')){
    $(this).parent().next().blindAndRemove()
  }
  $($.html.new_element_form(this.title))
    .insertAfter($(this).parent())
    .show('blind', {direction: 'vertical'})
    .ajaxForm({
      url: $('form.margin').attr('action').replace(/survey/,'inquiries'),
      dataType: 'json',
      success: function(data){
        $($.html.new_input_element(data))
          .appendTo('ul.survey')
          .show('blind', {direction: 'vertical'});
        $('.new_inputs+form').blindAndRemove()
      }
    })
  return false;
}
 
function deleteElement(){
  if(confirm('Are you sure you want to delete this?')){
    var self = $(this)
    $.ajax({
      type: "POST",
      data: {_method: "delete"},
      url: self.attr('href'),
      success: function(){
        self.parent().blindAndRemove();
      }
    })
  }
  return false;
}