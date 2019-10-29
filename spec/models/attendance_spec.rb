# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before :each do
    @user = User.new(name: 'tom')
    @user.save
    @event = @user.creator_events.build(date: Date.today, description: 'party')
    @event.save
    @attendant = Attendance.new(attendee_id: @user.id, attended_event_id: @event.id)
  end

  it 'should be a valid attendant' do
    expect(@attendant).to be_valid
  end

  it 'should be invalid without attendee_id' do
    @attendant = Attendance.new(attended_event_id: @event.id)
    expect(@attendant).to_not be_valid
  end

  it 'should be invalid without attended_event_id' do
    @attendant = Attendance.new(attendee_id: @user.id)
    expect(@attendant).to_not be_valid
  end
end
