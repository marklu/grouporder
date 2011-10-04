class Option < ActiveRecord::Base
  belongs_to :event
  
  def at_limit_for(realm) 
    if limit.nil?
      return false
    else
      return realm.orders_with_option(self).size >= limit
    end
  end

  def to_s
    return name
  end

end
