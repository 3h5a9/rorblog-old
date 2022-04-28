class Post < ApplicationRecord
  # rich text
  has_rich_text :content

  # validation
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 10, maximum: 60 }
  validates :content, presence: true, length: { minimum: 30 }

  # relationship
  has_many :comments, dependent: :destroy

  # Image
  has_one_attached :featured_image do |attachable|
    attachable.variant :widethumb, resize_to_fill: [740, 320] #indexpage thumb
    #attachable.variant :singthumb, resize_to_limit: [740, 320] #single page top image
  end
end
