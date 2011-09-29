class Realm < ActiveRecord::Base
  belongs_to :organization
  belongs_to :event

  def token_url
    return '/o/' + token
  end

  def admin_url
    return '/a/' + admin_token
  end

  def orders_with_option(option)
    return Order.where(:realm_id => self.id, :option_id => option.id)
  end
end
