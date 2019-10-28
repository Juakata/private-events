# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create_event', type: :feature do
  scenario 'should redirect to sign up page' do
    visit new_event_path
    expect(page).to have_content('Start your account')
  end

  scenario 'should be a valid event' do
    visit root_path
    fill_in('user_name', with: 'tom')
    click_button('commit')
    expect(page).to have_content('tom')
    visit new_event_path
    expect(page).to have_content('Create new event')
    fill_in('event_date', with: Date.tomorrow)
    fill_in('event_description', with: 'new event')
    expect(page).to have_content('new event')
  end
end
