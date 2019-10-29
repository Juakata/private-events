# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before :each do
    @user = User.new(name: 'tom')
    @user.save
    @event = @user.creator_events.build(date: Date.today, description: 'party')
    @event2 = Event.new(date: Date.today, description: 'another party')
  end

  it 'should be a valid event' do
    expect(@event).to be_valid
  end

  it 'should be invalid without user association' do
    expect(@event2).to_not be_valid
  end

  it 'should be an invalid date' do
    @event.date = Date.yesterday
    expect(@event).to_not be_valid
  end

  it 'should check for description' do
    @event.description = ' '
    expect(@event).to_not be_valid
  end
end
