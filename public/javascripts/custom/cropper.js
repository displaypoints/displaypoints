(function($) {
  $.cropper = function(klass, data){
    $.cropper.init(data);
    $.cropper.build(klass);
    return $.cropper.root;
  }

  $.extend($.cropper, {
    settings: {
      id          : '',
      oldHtml     : '',
      box         : {
        x       : 0, 
        y       : 0, 
        width   : 150, 
        height  : 150 
                    },
      wrapper     : null,
      resize      : null,
      root        : null,
      html: function(){
        return '<div id="'+$.cropper.settings.id+'"> \
         <div class="wrap_image"></div>\
         <div class="resizeme"></div> \
       </div>';
      }
    },
    init: function(opts){
       $.cropper.settings = $.extend($.cropper.settings, opts);
       $.cropper.settings.id = $.cropper.settings.id || 'cropper_'+Date.now().getTime();
    },
    build: function(imgSelector){
      var img = $(imgSelector)
      $.cropper.oldHtml = img[0]
      var size = [img.width(), img.height()]
      var source = img.attr('src');
      img.replaceWith($.cropper.settings.html())
      $.extend($.cropper, {
        root: $('#'+$.cropper.settings.id),
        wrapper:  $('#'+$.cropper.settings.id+' .wrap_image'),
        resize: $('#'+$.cropper.settings.id+' .resizeme')
      })
      $.cropper.root.css({
        width         : size[0], 
        height        : size[1], 
        float         : 'left', 
        'margin-right': '10px',
        position      : 'relative'
      });
      $.cropper.resize.css({ 
        background         :'transparent url('+source+') no-repeat scroll -1px -1px',
        backgroundPosition :'-' + $.cropper.settings.box.x + 'px -' + $.cropper.settings.box.y + 'px',
        width              : $.cropper.settings.box.width,
        height             : $.cropper.settings.box.height,
        top                : $.cropper.settings.box.y,
        left               : $.cropper.settings.box.x,
        position           : 'absolute'
      });
      $.cropper.wrapper.css({
        width         : size[0], 
        height        : size[1], 
        background    : 'transparent url('+source+') no-repeat scroll 0%',
        position      : 'relative'
      });
      $.cropper.wrapper.animate({ opacity: .5 }, "slow")
      $.cropper.root.trigger('cropper.build')
      $.cropper.start();
    },
    start: function(){
      $.cropper.resize.resizable({
        handles: 'e,se,s',
        knobHandles: true,
        autohide: true,
        minWidth: 20,
        minHeight: 20,
        resize: function(e, ui) {
          if((ui.position.left + ui.size.width) > $.cropper.root.innerWidth()){
            $.cropper.resize.css({width:($.cropper.root.innerWidth() - ui.position.left)})
          }
          if((ui.position.top + ui.size.height) > $.cropper.root.innerHeight()){
            $.cropper.resize.css({height:($.cropper.root.innerHeight() - ui.position.top)})
          }
          $.cropper.position(ui)
          $.cropper.root.trigger('cropper.change')
        },
        stop: function(e, ui) {
          $.cropper.position(ui)
        }
     })
     .draggable({
       cursor: 'move',
       containment: $.cropper.root,
       drag: function(e, ui) {
         this.style.backgroundPosition = '-' + (ui.position.left + 1) + 'px -' + (ui.position.top + 1) + 'px';
         $.cropper.position(ui)
         $.cropper.root.trigger('cropper.change')
       }
     });
     $.extend($.cropper.settings.box,{
       x      : parseInt($.cropper.position().x),
       y      : parseInt($.cropper.position().y),
       width  : parseInt($.cropper.position().width),
       height : parseInt($.cropper.position().width)
     })
     $.cropper.root.trigger('cropper.start')
    },
    cancel: function(){
      $.cropper.root.replaceWith($.cropper.oldHtml).trigger('cropper.cancel')
    },
    position: function(obj){
      $.cropper.settings.box = {
        x      : $.cropper.resize.position().left,
        y      : $.cropper.resize.position().top,
        width  : $.cropper.resize.innerWidth(),
        height : $.cropper.resize.innerHeight()
      }
      return $.cropper.settings.box;     
    }
  })
  $.fn.cropper = function(opts){
    $.cropper(this, opts);
    return $.cropper.root;
  }
})(jQuery);