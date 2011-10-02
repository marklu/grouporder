class Order < ActiveRecord::Base
  belongs_to :realm
  belongs_to :option
  has_many :payments
  validates :name, :length => { :minimum => 2 }
  validate :option_valid_for_event

  def option_valid_for_event
    if option
	  if option.event != realm.event
        errors.add(:option, "can't be for another event")
	  end
	end
  end

end
