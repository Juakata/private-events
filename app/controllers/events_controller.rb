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
    @events = Event.where("user_id != ? and id NOT IN(?)",
      current_user.id, Attendee.joins(:attended_events).all.select(:event_id).where("attendees.user_id = ?", current_user.id))
  end

  def show
    @attendees = AttendedEvent.joins(:event).where("event_id == ?", params[:id])
  end

  def join
    @attendee = Attendee.new(user_id: current_user.id)
    if @attendee.save
      @attended = @attendee.attended_events.build(event_id: params[:event_id])
      @attended.save
      redirect_to current_user
    end
  end

  private

  def events_params
    params.require(:event).permit(:date, :description)
  end
end
