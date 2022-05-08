# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  has_one_attached :avatar do |attachable|
    attachable.variant :avataricon, resize_to_fill: [32, 32]
    attachable.variant :avatarthumbnail, resize_to_fill: [300, 300]
  end
end
