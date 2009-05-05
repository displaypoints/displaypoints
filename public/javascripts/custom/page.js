function linkEditor(){
  $('#links ul.pages a').pageMenu();
  $('#links ul.pages li div a.remove').livequery('click', deletePage);
  $('#links ul.pages li div a.edit').livequery('click', enableLinkEditing);
  $('#child_page a.cancel').livequery('click', removeCropper);
  $('#new_page form').ajaxForm({
    dataType: "json",
    success: function(data){
      $(data).inspect();
      $('<a href="/page/'+data.id+'"><img src="/images/'+data.img+'" /></a>')
        .appendTo('#pages').show("clip", { direction: "horizontal" }, 500);
    }
  });
  $('a.child_page').click(function(){
    $('#child_page').show('blind',{ direction:'up' },1000);
    $(this).hide();
    $('#page img')
      .cropper({
        box: {
          x     : 0,
          y     : 0,
          width : 150,
          height: 150
        }
      })
      .bind('cropper.start', updateForm)
      .bind('cropper.change', updateForm);
    return false;
  });
}

$.fn.pageMenu = function(){
  function clickPage(){
    var id = $(this).parent().attr('id').split('_')[1];
    if($(this).parent().hasClass('selected')){
      $(this).parent().removeClass('selected').find('div').remove();
    }else{
      var url = this.href;
      var edit = '<a href="'+url+'/link/'+id+'/edit" class="edit">Edit</a>';
      var destroy = '<a href="'+url+'/link/'+id+'/remove" class="remove">Remove</a>';
      var view = '<a href="'+url+'" class="go">Go</a>';
      $(this).parent().addClass('selected').append('<div>'+edit+view+destroy+'</div>')
        .siblings().removeClass('selected').find('div').remove();
      $('#page').find('.rect').hide().end().find('#rect_'+id).show();
      $('form.edit_rect').remove();
      $('#child_page').hide();
      $('a.child_page').show();
    }
    return false;
  }
  
  function overPage(){
    if(!$(this).parent().hasClass('selected'))
      $('#page #rect_'+$(this).parent().attr('id').split('_')[1]).show();
  }
  
  function offPage(){
    if(!$(this).parent().hasClass('selected'))
      $('#page #rect_'+$(this).parent().attr('id').split('_')[1]).hide();
  }
  
  $(this).click(clickPage).hover(overPage,offPage);
};

function deletePage(){
  var parent = $(this).parents('li');
  var self = $(this);
  if(confirm('Are you sure you want to delete this?')){
    $.ajax({
      type: "POST",
      data: {_method: "delete"},
      url: self.attr('href').split('remove')[0],
      success: function(){ 
        parent.fadeOut('slow',function(){$(this).remove();});
        var n = parent.attr('id').split('_')[1];
        $('#rect_'+n).fadeOut('fast')
      }
    });
  }
  return false;
}

function removeCropper(){
  $(this).parents('form').hide();
  $('a.child_page').show();
  $.cropper.cancel();
  $('form.edit_rect').remove();
  return false;
}

function updateLink(){
  var new_size = {
    width: $('#link_width').val(), 
    height: $('#link_height').val(), 
    top: $('#link_y').val(), 
    left: $('#link_x').val()
  };
  $('form.edit_rect').remove();
  var id = $('li.selected').attr('id').split('_')[1];
  $.cropper.cancel();
  $('#page #rect_'+id).css({top: new_size.top+"px", left: new_size.left+"px"})
    .find('span').css({height: new_size.height+"px", width: new_size.width+"px"}).end().show();
  $('a.child_page').show();
}

function enableLinkEditing(){
  var id = $(this).parents('li').attr('id').split('_')[1];
  var rect = $('#page #rect_'+id);
  var size = {
    width: rect.find('span').innerWidth(), 
    height: rect.find('span').innerHeight(), 
    top: rect.position().top, 
    left: rect.position().left
  };
  $('.edit_rect').remove();
  $($.html.link_edit_form(window.location.href, id, size)).insertAfter('#links');
  $('#child_page, a.child_page, .rect').hide();
  $('#page img')
    .cropper({
        box: {
          x       : size.left,
          y       : size.top,
          width   : size.width,
          height  : size.height
        }
    })
    .bind('cropper.start', updateForm)
    .bind('cropper.change', updateForm);
  $('form.edit_rect').ajaxForm({ dataType: "json", data: {_method:"put"}, success: updateLink });
  $('.edit_rect a.cancel').click(removeCropper);
  return false;
}

function updateForm(){
  $("#link_x").val($.cropper.position().x);
  $("#link_y").val($.cropper.position().y);
  $("#link_height").val($.cropper.position().height);
  $("#link_width").val($.cropper.position().width);
}