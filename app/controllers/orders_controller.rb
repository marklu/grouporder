class OrdersController < ApplicationController
  def create
    possible_match = Order.find_by_name(params[:order][:name])
    if possible_match.nil?
      @order = Order.new(params[:order])
    else
      @order = possible_match
      @order.update_attributes(params[:order])
    end
    if @order.realm_id != session[:realm_id]
      raise Exception
    end
    @order.save
    redirect_to @order
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.realm_id != session[:realm_id]
      raise Exception
    end
    @order.delete
    realm = Realm.find(session[:realm_id])
    if session[:realm_admin]
      redirect_to realm.admin_url
    else
      redirect_to realm.token_url
    end
  end

  def lookup
    if params[:name].length > 2
      @order = Order.find_by_name_and_realm_id(params[:name], session[:realm_id])
    else
       raise Exception
    end
    if @order.nil?
       session[:name] = params[:name]
       redirect_to new_order_path
    else
       session[:order_id] = @order.id
       redirect_to edit_order_path(@order)
    end
  end

  def new
    @realm = Realm.find(session[:realm_id])
    @options = Option.where(:event_id => @realm.event)
    @order = Order.new(:realm_id => @realm.id, :name => session[:name])
  end

  def edit
    @realm = Realm.find(session[:realm_id])
    @options = @realm.event.options
    @order = Order.find(params[:id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.realm_id != session[:realm_id]
      raise Exception
    end
    @order.update_attributes(params[:order])
    redirect_to @order
  end

  def pay
    @order = Order.find(params[:id])
    redirect_to Payment.generate_checkout :order => @order, :callback_uri => url_for(:action => "confirm", :controller => "payments", :only_path => false), :redirect_uri => url_for(:action => "thanks", :controller => "payments", :only_path => false)
  end
end
