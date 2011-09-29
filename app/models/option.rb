class Option < ActiveRecord::Base
  belongs_to :event
  def to_s
    return name
  end
end
