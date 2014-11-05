class Runner < ActiveRecord::Base
	
  self.primary_key = 'place'
  
  belongs_to :race
  
  before_validation :convert_durations_to_integers
  
  def convert_durations_to_integers
    self.gun_time = ChronicDuration::parse(self.gun_time_before_type_cast) if attribute_present?("gun_time")
    self.gun_pace = ChronicDuration::parse(self.gun_pace_before_type_cast) if attribute_present?("gun_pace")
    self.net_time = ChronicDuration::parse(self.net_time_before_type_cast) if attribute_present?("net_time")
    self.net_pace = ChronicDuration::parse(self.net_pace_before_type_cast) if attribute_present?("net_pace")
  end

  def gun_time
    ChronicDuration.output(read_attribute(:gun_time), :format => :chrono)
  end

  def gun_pace
    ChronicDuration.output(read_attribute(:gun_pace), :format => :chrono)
  end

  def net_time
    ChronicDuration.output(read_attribute(:net_time), :format => :chrono)
  end

  def net_pace
    ChronicDuration.output(read_attribute(:net_pace), :format => :chrono)
  end	
end
