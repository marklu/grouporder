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
    unless @realm.nil?
      session[:realm_id] = @realm.id
      session[:realm_admin] = true
      @orders = Order.where(:realm_id => @realm.id)
      @optioncounts = @realm.option_counts
      @total = @realm.total_cost
      @paid = @realm.total_paid
      @balance = @realm.balance
      @payments = @realm.payments
    end
  end
end
