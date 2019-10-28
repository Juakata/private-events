# frozen_string_literal: true

class EventsController < ApplicationController
  def create
    @event = current_user.creator_events.build(events_params)
    if @event.save
      redirect_to @current_user
    else
      render 'new'
    end
  end

  def new
    @event = Event.new
  end

  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
    @past_events_id = Event.past.map(&:id)
    @events_user = Event.where('creator_id = ?', current_user.id).map(&:id)
    @events_joined = User.user_upcoming_events(current_user.id).map(&:id)
  end

  def show
    @attendees = User.joins(:attendances).where('attended_event_id == ?', params[:id])
  end

  def join
    @attendance = Attendance.new(attendee_id: current_user.id, attended_event_id: params[:event_id])
    if @attendance.save
      redirect_to current_user
    else
      flash[:error] = 'Unable to join to the event.'
      render 'index'
    end
  end

  private

  def events_params
    params.require(:event).permit(:date, :description)
  end
end
