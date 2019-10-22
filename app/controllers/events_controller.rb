class EventsController < ApplicationController
  def create
    @event = current_user.events.build(events_params)
    if @event.save 
      redirect_to @current_user
    else
      render "new"
    end
  end

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  private

  def events_params
    params.require(:event).permit(:date, :description) 
  end
end
