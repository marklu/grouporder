class Realm < ActiveRecord::Base
  belongs_to :organization
  belongs_to :event

  before_create do
    if self.token.nil?
      self.token = SecureRandom.hex(8)
    end
    if self.admin_token.nil?
      self.admin_token = SecureRandom.hex(8)
    end
  end

  def token_url
    return '/o/' + token
  end

  def admin_url
    return '/a/' + admin_token
  end

  def orders_with_option(option)
    return Order.where(:realm_id => self.id, :option_id => option.id)
  end

  def option_counts
    options = Option.where(:event_id => self.event.id)
    result = {}
    options.each do |option|
      result[option] = self.orders_with_option(option).size()
    end
    return result
  end
end
