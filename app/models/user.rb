# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :validatable
  enum role: {
    director: 'director',
    accountant: 'accountant',
    storekeeper: 'storekeeper'
  }
  validates :email, presence: true, format: Devise.email_regexp
  validates :role, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 8 }
end
