class Event < ActiveRecord::Base
  has_many :options
  has_many :realms

  def option_counts
    realms = self.realms
    options = Option.where(:event_id => self.id)
    result = {}
    options.each do |option|
      result[option] = 0
    end
    realms.each do |realm|
      optioncounts = realm.option_counts
      optioncounts.each_key do |option|
        result[option] += optioncounts[option]
      end
    end
    return result
  end
end
