class Order < ActiveRecord::Base
  belongs_to :realm
  belongs_to :option
  has_many :payments
  validates :name, :length => { :minimum => 2 }
  validate :option_valid_for_event
  validate :not_past_limit

  def option_valid_for_event
	if option.event != realm.event
      errors.add(:option, "can't be for another event")
	end
  end

  def not_past_limit
    if option.at_limit_for(realm)
      errors.add(:option, "past limit for option")
    end
  end

end
