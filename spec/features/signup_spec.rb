# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signup', type: :feature do
  scenario 'should be a valid signup' do
    visit root_path
    fill_in('user_name', with: 'tom')
    click_button('commit')
    expect(page).to have_content('tom')
  end

  scenario 'should be an invalid signup' do
    @user = User.create(name: 'tom')

    visit root_path
    fill_in('user_name', with: 'tom')
    click_button('commit')
    expect(page).to have_content('Name has already been taken')
  end
end
