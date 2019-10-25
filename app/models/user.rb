# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :creator_events, foreign_key: 'creator_id', class_name: 'Event'

  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances, class_name: 'Event'

  scope :upcoming, ->(id) { Event.joins(:attendances).where('attendee_id == ?', id).upcoming }
  scope :past, ->(id) { Event.joins(:attendances).where('attendee_id == ?', id).past }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def update_remember_digest
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(token)
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def upcoming_events
    User.upcoming(id)
  end

  def past_events
    User.past(id)
  end
end
