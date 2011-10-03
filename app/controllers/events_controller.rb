class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    if session[:event_id] != @event.id or session[:password] != @event.password
      redirect_to auth_event_path(@event.id)
    end
    @realms = Realm.where(:event_id => @event.id).includes("organization").order("organizations.name ASC")

    respond_to do |format|
      format.html
      format.csv
    end
  end  

  def new
    @event = Event.new()
    @organizations = Organization.all
  end

  def create
    @event = Event.create(params[:event])
    @participants = params[:participants]
    @participants.each_key do |participant_id|
      Realm.create(:event => @event, :organization => Organization.find(participant_id))
    end
    @options = params[:options]
    @options.each_key do |n|
      option = @options[n]
      unless option[:name].empty?
        Option.create(:event => @event, :name => option[:name], :price => option[:price])
      end
    end
    redirect_to @event
  end

  def auth
    @event = Event.find(params[:id])
    unless params[:password].nil?
      if params[:password] == @event.password
        session[:password] = params[:password]
        session[:event_id] = @event.id
        redirect_to @event
      end
    end
  end
end
