class Order < ActiveRecord::Base
  belongs_to :realm
  belongs_to :option
  validates :name, :length => { :minimum => 2 }
  validate :option_valid_for_event

  def option_valid_for_event
    if option
	  if option.event != realm.event
        errors.add(:option, "can't be for another event")
	  end
	end
  end

  def pay_url
    headers = { "Authorization" => "Bearer #{WEPAY[:access_token]}" }
    query = { :account_id => WEPAY[:account], :short_description => realm.event.name, :type => "GOODS", :amount => option.price }
    response = HTTParty.get "#{WEPAY[:api_base]}/checkout/create", :headers => headers, :query => query
    CheckoutReference.create(:realm => realm, :comment => name, :checkout_id => response["checkout_id"])
    return response["checkout_uri"]
  end
end
