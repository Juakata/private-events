# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, class_name: 'User'

  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :past, -> { where('date < ?', Date.today) }
  validates :description, presence: true
  validate :correct_date

  def correct_date
    errors.add(:warning, 'Invalid date') unless date.present? && date >= Date.today
  end
end
