class Survey
  include DataMapper::Resource
  
  property :id, Serial
  property :token,  DM::UUID, :nullable => false, :default => lambda { ::UUID.timestamp_create }, :index => true
  property :top_margin, Integer, :default => 0

  has n, :inquiries, :class_name => "Inquiry", :order => [:order.asc]
  belongs_to :page
  
  def inquiry_ids=(ids)
    ids.each_with_index do |input, i|
      inquiry = Inquiry.get(input.to_i)
      inquiry.update_attributes(:order => i, :survey_id => self.id)
    end
  end
end
