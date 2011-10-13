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

  def auth_wepay(args = {})
    wepay_client_id = ENV['WEPAY_CLIENT_ID']
    wepay_client_secret = ENV['WEPAY_CLIENT_SECRET']
    query = { :client_id => wepay_client_id,
              :redirect_uri => args[:redirect_uri],
              :client_secret => wepay_client_secret,
              :code => args[:code] }
    response = HTTParty.get "#{WEPAY[:api_base]}/oauth2/token", :query => query
    logger.info response
    if response["access_token"]
      self.wepay_access_token = response["access_token"]
      self.save
    end
  end

  def auth_wepay_uri(redirect_uri)
    wepay_client_id = ENV['WEPAY_CLIENT_ID']
    wepay_client_secret = ENV['WEPAY_CLIENT_SECRET']
    return "#{WEPAY[:api_base]}/oauth2/authorize?client_id=#{wepay_client_id}&redirect_uri=#{redirect_uri}&scope=manage_accounts,view_balance,collect_payments,refund_payments,view_user"
  end
end
