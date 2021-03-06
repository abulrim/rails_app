# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, if: -> { password.present? }

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name=(val)
    pieces = val.split
    self.first_name = pieces[0]
    self.last_name = pieces[1]
  end

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def admin?
    role == 'admin'
  end
end
