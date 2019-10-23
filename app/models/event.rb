class Event < ApplicationRecord
  belongs_to :user
  has_many :attended_events
  has_many :attendees, through: :attended_events
end
