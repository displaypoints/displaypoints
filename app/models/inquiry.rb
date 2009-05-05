class Inquiry
  include DataMapper::Resource
  
  property :id, Serial
  property :question, String, :length => 200
  property :answer, String, :default => '', :length => 200
  property :type, Enum[:text, :radio, :slider, :date, :email]
  property :choices, Yaml, :default => ''
  property :order, Integer
#  property :x_pos, Integer
#  property :y_pos, Integer
#  property :width, Integer
#  property :height, Integer

  belongs_to :survey

  def serialize
    {:id => self.id,
     :order => self.order,
     :question => self.question,
     :choice_type => self.type,
     :choices => self.choices,
     :correct_answer => self.answer}
  end
end
