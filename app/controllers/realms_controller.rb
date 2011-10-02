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

  def pay
    @realm = Realm.find_by_admin_token(params[:admin_token])
    @amount = params[:amount]
    redirect_to Payment.generate_checkout :realm => @realm, :amount => @amount, :callback_uri => url_for(:action => "confirm", :controller => "payments", :only_path => false), :redirect_uri => url_for(:action => "thanks", :controller => "payments", :only_path => false)
  end
end
