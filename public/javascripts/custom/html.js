$.html = {
  link_edit_form: function(location, id, size){
    return ' \
<form method="post" action="'+location+'/link/'+id+'" enctype="multipart/form-data" class="edit_rect"> \
<input type="hidden" name="_method" value="put"/> \
<input type="hidden" id="link_x" name="link[x_coord]" value="'+size.top+'" class="hidden"/> \
<input type="hidden" id="link_y" name="link[y_coord]" value="'+size.left+'" class="hidden"/> \
<input type="hidden" id="link_width" name="link[width]" value="'+size.width+'" class="hidden"/> \
<input type="hidden" id="link_height" name="link[height]" value="'+size.height+'" class="hidden"/> \
<input type="submit" name="submit" value="Update"/> \
<a href="#" class="cancel"> Cancel</a> \
</form>';
  },
  new_form: function(klass,body, path){
    return ' \
<form class="'+klass+'" method="post" action="'+(path || '#')+'" style="display:none"> \
'+body+' \
</form>';
  },
  new_input_element: function(data){
    var body;
    switch(data.choice_type){
      case 'text':
        body = '<div>Sample Text</div>';
        break;
      case 'radio':
        body = $.map(data.choices, function(val, i){
          return '<div>'+val+'</div>'
        }).join('');
        break;
      case 'email':
        body = '<div>bob@email.com</div>';
        break;
      case 'slider':
        body = '<div></div>';
        break;
      case 'date':
        body = '<div><div class="month">12</div><div class="day">16</div><div class="year">2008</div></div>';
        break;
    }
    return '<li id="inquiry_'+data.id+'" class="'+data.choice_type+' input"> \
<a class="delete" href="' +
      $('form.margin').attr('action').replace(/survey/,'inquiries/') + data.id +
      '">X</a><a href="" class="edit"><img src="/images/pencil.png"/></a><label>' + data.question + '</label>' + body + '</li>';
  },
  buttons: function(text){
    return ' \
<div class="buttons"> \
<input type="submit" value="'+text+'" name="submit"/> \
<a href="#" class="cancel">Cancel</a> \
</div>';
  },
  new_element_form: function(type){
    return $.html.new_form(type, ' \
<div> \
<label for="inquiry_question">Question</label> \
<div class="hint">What is it you want to ask</div> \
<input id="inquiry_question" name="inquiry[question]" type="text" class="text" /> \
</div> \
<input type="hidden" name="inquiry[type]" id="inquiry_type" value="'+type+'"/>' +
      $.html.input_body(type) +$.html.buttons('Create'));
  },
  input_body: function(type){
    switch(type){
      case 'radio':
        return '\
<div> \
<label for="inquiry_choices">Choices</label> \
<input id="inquiry_choices_1" name="inquiry[choices][]" type="text" class="text" /> \
<a href="#" class="new_choice">Add Another</a> \
</div> \
';
        break;
      default:
        return '';
        break;
    }
  }
}