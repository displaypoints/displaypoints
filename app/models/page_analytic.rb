require 'json'

class PageAnalytic
  include DataMapper::CouchResource
  
  def self.default_repository_name
    :analytics
  end

  property :coordinates,      DataMapper::Types::JsonObject
  property :from_page,        String
  property :to_page,          String
  property :action,           String
  property :link_id,          String
  property :timestamp,        DateTime
  property :display_mac,      String
  property :router_mac,       String
  
  class << self 
    def parse_date(date)
      d = date.strip.match(/(.+)\s-\s(.+)/)
      return Time.parse(d[1]), nil if d[2].nil?
      return Time.parse(d[1]), Time.parse(d[2])
    end
    
    def format_campaign_for_ofc(parent_obj,type,date)
      start_date, end_date = parse_date(date)
      tokens = parent_obj.content_items.map{|ci| ci.pages}.flatten.map{|pg| pg.token.to_s}
      opts = {:group => true, :keys => tokens}
      data = nil

      repository(:analytics) do
        data = self.send(:"#{type.plural}",opts)
      end
      data = (type == 'link') ? reduce_for_links(data) : reduce(data.map{|row| row['value']})
      reduce_for_ofc(data, start_date, end_date)
    end
    
    def format_content_item_for_ofc(parent_obj,type,date)
      start_date, end_date = parse_date(date)
      tokens = parent_obj.pages.map{|pg| pg.token.to_s}
      opts = {:group => true, :keys => tokens}
      data = nil

      repository(:analytics) do
        data = self.send(:"#{type.plural}", opts)
      end
      data.inject({}) do |hsh, row|
        data = (type == 'link') ? reduce(row['value'].values) : row['value']
        hsh[row['key']] = reduce_for_ofc(data,start_date, end_date)
        hsh
      end
    end
    
    def reduce_for_links(data)
      reduce(data.map{|row| row['value']}.map{|l| l.values}.flatten)
    end
    
    def reduce(data)
      data.inject({}) do |hsh, dates|
        dates.each{|k,v| (hsh.has_key?(k)) ? hsh[k] += v : hsh[k] = v }
        hsh
      end
    end
    
    def reduce_for_ofc(data, start_date, end_date)
      (start_date..end_date).to_days.map do |day|
        day_fmt = day.strftime('%Y-%m-%d')
        [day, data[day_fmt] || 0]
      end
    end
    
    
    def summary_for_pages(obj)
      pg_tokens = obj.map{|pg| pg.token.to_s}
      
    end
    
    def horiz_grid(steps, max)
      return 4 if max < 4
      incr = max/steps
      base = Math.log10(max/steps).round
      size = (incr/10**base.to_f).ceil * 10**base
    end
  end
  
  date_snippet = "var d = new Date(doc.timestamp);
  function padZero(num){ return num >= 10 ? num : '0'+num }
  var date = d.getFullYear()+'-'+padZero(d.getMonth()+1)+'-'+padZero(d.getDate());"
    
  %w(touch user_rotation auto_rotation).each do |type|
    view(type.plural.to_sym){{
      "map" => "function(doc) {
        if(doc.action == '#{type}'){
          #{date_snippet}
          emit(doc.from_page,date);
        }
      }",
      "reduce" => "function(keys, values, rereduce){
        var data = {};
        for(var idx in values){
          var date = values[idx];
          if(data[date] != undefined){
            data[date] += 1;
          }else{
            data[date] = 1;
          }
        }
        return data;
      }"
    }}
  end
  
  #content_item
  
  view(:links){{
    "map" => "function(doc) {
      if(doc.action == 'link'){
        #{date_snippet}
        emit(doc.from_page,[doc.link_id,date]);
      }
    }",
    "reduce" => "function(keys, values, combine){
      if(combine){
        var data = {}
        for(var idx in values){
          var elem = values[idx];
          for(var key in elem){
            if(data[key] == undefined){
              data[key] = {};
            }
            var dates = elem[key];
            for(var nKey in dates){
              if(data[key][nKey] == undefined){
                data[key][nKey] = dates[nKey];
              }else{
                data[key][nKey] += dates[nKey];
              }
            }
          }
        }
        return data;
      }else{
        var data = {};
        for(var idx in values){
          var elem = values[idx];
          if(data[elem[0]] == undefined){
            data[elem[0]] = {}
          }
          if(data[elem[0]][elem[1]] == undefined){
            data[elem[0]][elem[1]] = 1;
          }else{
            data[elem[0]][elem[1]] += 1;
          }
        }
        return data;
      }
    }"
  }}
  
  view(:summary_by_page){{
    "map" => "function(doc) {
      #{date_snippet}
      emit(doc.from_page, [date, doc.action]);
    }",
    "reduce" => "function(keys, values, combine){
      if(combine){
        var data = {}
        for(var idx in values){
          var elem = values[idx];
          for(var key in elem){
            if(data[key] == undefined){
              data[key] = {};
            }
            var dates = elem[key];
            for(var nKey in dates){
              if(data[key][nKey] == undefined){
                data[key][nKey] = dates[nKey];
              }else{
                data[key][nKey] += dates[nKey];
              }
            }
          }
        }
        return data;
      }else{
        var data = {};
        for(var idx in values){
          var elem = values[idx];
          if(data[elem[0]] == undefined){
            data[elem[0]] = {}
          }
          if(data[elem[0]][elem[1]] == undefined){
            data[elem[0]][elem[1]] = 1;
          }else{
            data[elem[0]][elem[1]] += 1;
          }
        }
        return data;
      }
    }"
  }}
end

class DateTime
  def to_json
    to_time.utc
    %Q("#{strftime "%Y/%m/%d %H:%M:%S +0000"}")
  end
end