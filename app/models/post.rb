# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  # rich text
  has_rich_text :content

  # validation
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 10, maximum: 60 }
  validates :content, presence: true, length: { minimum: 30 }

  # relationship
  has_many :comments, dependent: :destroy

  # Image
  has_one_attached :featured_image do |attachable|
    attachable.variant :widethumb, resize_to_fill: [740, 320]
    attachable.variant :herothumb, resize_to_fill: [570, 370]
  end

  enum posttype: %i[normal featured]

  scope :featured, -> { where(posttype: 1)}

  acts_as_votable
end
