class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @realms = Realm.where(:event_id => @event.id)
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
end
