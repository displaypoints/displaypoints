(function($){
  $.fn.tableSearch = function(opts){
    options = $.extend($.tableSearch.options,opts);
    var self = $(this), 
      rows = $(this).find('tbody tr'),
      cache = rows.map(function(){
        return $(this).find('td').map(function(){
          return $(this).text().toLowerCase();
        });
      });
    $(' \
      <form> \
        <label for="ts_input">'+ options.labelText +'</label> \
        <input type="text" id="ts_input" class="text" /> \
      </form> \
    ').insertBefore(self).submit(function(){ return false;});
    self.prev().find('input.text').keyup(function(){
      var scores = $.tableSearch.filter(cache, $(this).val().toLowerCase());
      rows.hide();
      $.each(scores.sort(function(a, b){return b[0] - a[0];}), function(i, val){
        rows.eq(val[1]).show();
      });
    });
    return this;
  };
  
  $.tableSearch = {
    options: {
      labelText: "Search"
    },
    filter: function(cache, term){
      var scores = [];
      $.each(cache, function(i, val){
        var score = 0;
        $.each(val, function(i, val){ score += val.score(term);});
        if(score > 0){scores.push([score, i]);}
      });
      return scores;
    }
  };
})(jQuery);;