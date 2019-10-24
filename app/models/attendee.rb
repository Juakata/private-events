# frozen_string_literal: true

class Attendee < ApplicationRecord
  belongs_to :user
  has_many :attended_events
  has_many :events, through: :attended_events
end
