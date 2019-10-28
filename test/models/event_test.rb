# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "tom")
    @user.save
    @party = Event.new(date: Date.today, description: "party", creator_id: @user.id)
  end

  test "should be valid" do
    assert @party.valid?
  end

  test "should require user.id" do
    @party = Event.new(date: Date.today, description: "party")
    assert_not @party.valid? 
  end
end
