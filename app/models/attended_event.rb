# frozen_string_literal: true

class AttendedEvent < ApplicationRecord
  belongs_to :attendee
  belongs_to :event
end
