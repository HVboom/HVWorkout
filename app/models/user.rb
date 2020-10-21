# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  before_validation :sanitize_parameter

  validates :nickname, uniqueness: { case_sensitive: false }, presence: true


  private

  def sanitize_parameter
    self.nickname.squish!
  end
end
