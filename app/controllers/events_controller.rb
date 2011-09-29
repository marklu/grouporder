class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @realms = Realm.where(:event_id => @event.id)
  end  
end
