# should this be CronScheduling?
class CronSchedule
  include DataMapper::Resource

  property :id, Serial
  property :day_of_week, String
  property :month, String
  property :day_of_month, String
  property :hour, String
  property :minute, String
#  property :campaign_id, Integer, :nullable => false
#  property :content_item_id, Integer, :nullable => false

#  belongs_to :campaign
  belongs_to :content_item

  def to_s
    "#{minute} #{hour} #{day_of_month} #{month} #{day_of_week}"
  end

  alias_method :to_json, :to_s
end
