class Payment < ActiveRecord::Base
  belongs_to :realm
  belongs_to :order

  def confirm
    headers = { "Authorization" => "Bearer #{WEPAY[:access_token]}" }
    query = { :checkout_id => checkout_id }
    response = HTTParty.get "#{WEPAY[:api_base]}/checkout", :headers => headers, :query => query
    print response
    if response["state"] == "captured"
      self.amount = response["amount"]
      self.description = "Online payment for #{subject}"
      self.save
    elsif ["authorized", "started", "reserved"].include? response["state"]
      self.amount = response["amount"]
      self.save
    elsif response["state"] == "refunded"
      self.amount = 0.00
      self.description = "Refunded payment for #{subject} (#{reponse["amount"]})"
      self.save
    elsif response["state"] == "charged back"
      self.amount = 0.00
      self.description = "Chargeback for #{subject} (#{response["amount"]})"
      self.save
    elsif response["state"] == "cancelled" or response["state"] == "failed"
      self.delete
    end
  end

  def self.generate_checkout(args = {})
    realm = args[:realm]
    order = args[:order]
    realm ||= order.realm
    description = realm.organization.name
    unless order.nil?
      amount = order.option.price
      description = order.name
    end
    unless args[:amount].nil?
      amount = args[:amount]
    end
    headers = { "Authorization" => "Bearer #{WEPAY[:access_token]}" }
    query = { :account_id => realm.event.wepay_account,
              :short_description => "#{realm.event.name}, #{description}",
              :type => "GOODS",
              :callback_uri => args[:callback_uri],
              :redirect_uri => args[:redirect_uri],
              :amount => amount }
    response = HTTParty.get "#{WEPAY[:api_base]}/checkout/create", :headers => headers, :query => query
    result = Payment.create :realm => realm, :order => order, :description => "Pending payment for #{description}", :amount => 0.0, :checkout_id => response["checkout_id"]
    return response["checkout_uri"]
  end

  def subject
    if order.nil?
      return realm.organization.name
    else
      return order.name
    end
  end
end
