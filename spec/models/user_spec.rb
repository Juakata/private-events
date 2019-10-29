# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'tom')
  end

  it 'is not valid without a name' do
    expect(@user).to be_valid
  end

  it 'is not a valid user' do
    @user.name = ' '
    expect(@user).to_not be_valid
  end

  it 'should be unique' do
    @user.save
    @user2 = User.new(name: 'tom')
    expect(@user2).to_not be_valid
  end
end
