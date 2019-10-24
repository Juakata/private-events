# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :events
  has_many :attendees
  scope :event_ids, ->(id) { Attendee.joins(:attended_events).select(:event_id).where('user_id == ?', id) }
  scope :upcoming, ->(id) { Event.where('id IN (?) and date >= ?', User.event_ids(id), Date.today) }
  scope :past, ->(id) { Event.where('id IN (?) and date < ?', User.event_ids(id), Date.today) }

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
