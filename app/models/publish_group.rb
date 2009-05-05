# the WHERE & WHEN  # should/can we break this up?
class PublishGroup
  include DataMapper::Resource

  property :id,         Integer, :serial => true
  property :name,       String, :length => 256
  property :type,       Discriminator

  is :permalink, :name, :length => 60

  #has 1, :runtime_tag # i think this should be part of the contract
  #has n, :tags,      :through => Resource
  has n, :venue_assignments
  has n, :venues,    :through => :venue_assignments

  has n, :state_assignments
  has n, :states,    :through => :state_assignments

  has n, :city_assignments
  has n, :cities,    :through => :city_assignments
  
  has n, :zipcode_assignments
  has n, :zipcodes,  :through => :zipcode_assignments
  
  has n, :campaigns, :through => Resource
 
  belongs_to :user
  
  validates_present :user

  %w(state city zipcode venue).each do |type|
    class_eval <<-RUBY, __FILE__, __LINE__
      def inc_#{type.plural}
        @inc_#{type.plural} ||= self.#{type}_assignments.map {|ass| ass.#{type} if ass.included }.compact
      end
    
      def ex_#{type.plural}
        @ex_#{type.plural} ||= self.#{type}_assignments.map {|ass| ass.#{type} unless ass.included }.compact
      end
      
      def #{type}_ids=(ids)
        ids.each do |#{type}_id|
          #{type}_assignments << #{type.titlecase}Assignment.create(:#{type}_id => #{type}_id, :included => true)
        end
      end

      def #{type}_ids
        inc_#{type.plural}.map{|ass| ass.id}
      end

      def not_#{type}_ids=(ids)
        ids.each do |#{type}_id|
          #{type}_assignments << #{type.titlecase}Assignment.create(:#{type}_id => #{type}_id, :included => false)
        end
      end

      def not_#{type}_ids
        ex_#{type.plural}.map{|ass| ass.id}
      end
    RUBY
    unless type == 'venue'
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def inc_#{type}_venues
          Venue.all(Venue.#{type}.id.in => #{type}_ids)
        end

        def ex_#{type}_venues
          Venue.all(Venue.#{type}.id.in => not_#{type}_ids)
        end
      RUBY
    end
  end
  
  def self.all_for_user(user)
    if user.root?
        return all
    elsif user.admin?
        return all(PublishGroup.user.corporation.id => user.corporation.id)
    else
        all(PublishGroup.user.id => user.id)
    end
  end

  def venue_set
    include_venues = (inc_state_venues + inc_city_venues + inc_zipcode_venues + inc_venues).uniq
    exclude_venues = (ex_state_venues + ex_city_venues + ex_zipcode_venues + ex_venues).uniq
    return (include_venues - exclude_venues).uniq
  end

  def includes?(venue)
    self.venue_set.include?(venue)
  end

  #before :save do
  #  [
  #    :states,
  #    :cities,
  #    :zipcodes
  #  ].each do |klass|
  #    self.send(klass).entries
  #    many_to_many_model = self.class.relationship[klass].child_model
  #    unless self.send(klass) == many_to_many_model.all(:publish_group_id => self.id)
  #      many_to_many_model.all(:publish_group_id => self.id).destroy!
  #    end
  #  end
  #end
end
