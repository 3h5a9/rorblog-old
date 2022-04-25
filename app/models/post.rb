class Post < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 10, maximum: 60 }
  validates :content, presence: true, length: { minimum: 30 }
end
