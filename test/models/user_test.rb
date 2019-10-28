# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "tom")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do 
     @user.name = "" 
     assert_not @user.valid?
  end

  test "user is unique" do 
    @user.name = "tom" 
    @user.save
    @user2 = User.new(name: "tom")
    assert_not @user2.valid?
 end
end