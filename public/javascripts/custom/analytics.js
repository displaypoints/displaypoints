function enableAnalytics(){
  if($('#analyticsGraph').length > 0){
    analytics();
  }
  var defaults = [
		{text: 'Last 7 days', dateStart: 'today-7days', dateEnd: 'today' },
		{text: 'Month to date', dateStart: function(){ return Date.parse('today').moveToFirstDayOfMonth();  }, dateEnd: 'today' },
		{text: 'Year to date', dateStart: function(){ var x= Date.parse('today'); x.setMonth(0); x.setDate(1); return x; }, dateEnd: 'today' }
  ];
  $('#contractsTable tbody tr').each(function(){
    var self = $(this);
    var range = {
      dateStart: self.find('td.start').text(),
      dateEnd: self.find('td.end').text()
    };
    range['text'] = "Contract("+range.dateStart+'-'+range.dateEnd+")";
    defaults.push(range);
  });
  $('#dateRange').val(Date.today().addDays(-7).toString('M/d/yyyy')+' - '+Date.today().toString('M/d/yyyy'))
    .blur(updateData)
    .daterangepicker({
      posX: $('#dateRange').position().left,
  		posY: $('#dateRange').position().top + $('#dateRange').outerHeight() + 1,
  		arrows: true,
  		presets: ['Date Range'],
  		dateformat: 'mm/dd/yy',
      presetRanges: defaults
    });
  $('#dataType').val('user_rotation').change(updateData);
}

function updateData(){
  $.ajax({
    dataType: 'json',
    data:{
      date: $('#dateRange').val(), 
      type: $('#dataType').val()
    },
    url: window.location.href + '/analytics.json',
    success: function(data){
      var chart = findSWF('analyticsGraph');
      chart.load($.toJSON(data));
    }
  });
}

function findSWF(movieName) {
  if (navigator.appName.indexOf("Microsoft")!= -1) {
    return window[movieName];
  } else {
    return document[movieName];
  }
}

function analytics(){
  var flashvars = {
    'data-file': window.location.href + '/analytics.json'
  };
  var params = {
    menu: "false",
    scale: "noscale",
    wmode: "transparent"
  };
	var attributes = {};
	swfobject.embedSWF("/images/open-flash-chart.swf", 'analyticsGraph', "950", "250", "9.0.0", "/images/expressInstall.swf", flashvars, params, attributes);
}