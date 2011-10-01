class Realm < ActiveRecord::Base
  belongs_to :organization
  belongs_to :event
  has_many :payments

  before_create do
    if self.token.nil?
      self.token = SecureRandom.hex(8).force_encoding('UTF-8')
    end
    if self.admin_token.nil?
      self.admin_token = SecureRandom.hex(8).force_encoding('UTF-8')
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

  def total_cost
    options = event.options
    result = 0
    options.each do |option|
      unless option.price.nil?
        result += option.price * self.orders_with_option(option).size()
      end
    end
    return result
  end

  def total_paid
    return payments.sum :amount
  end

  def balance
    return total_cost - total_paid
  end

  def pay_url(amount)
    amount ||= balance
    headers = { "Authorization" => "Bearer #{WEPAY[:access_token]}" }
    query = { :account_id => WEPAY[:account], :short_description => realm.event.name, :type => "GOODS", :amount => amount }
    response = HTTParty.get "#{WEPAY[:api_base]}/checkout/create", :headers => headers, :query => query
    CheckoutReference.create(:realm => realm, :comment => organization.name, :checkout_id => response["checkout_id"])
    return response["checkout_uri"]
  end
end
