class RealmsController < ApplicationController
  def order 
    @realm = Realm.find_by_token(params[:token])
    if(@realm)
      session[:realm_admin] = false
      session[:realm_id] = @realm.id
    end
  end

  def admin
    @realm = Realm.find_by_admin_token(params[:admin_token])
    if(@realm)
      session[:realm_id] = @realm.id
      session[:realm_admin] = true
    end
    @orders = Order.where(:realm_id => @realm.id)
    @options = Option.where(:event_id => @realm.event.id)
    @optioncounts = {}
    @options.each do |option|
      @optioncounts[option] = @realm.orders_with_option(option).size()
    end
  end
end
