class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  # accepts_nested_attributes_for :comments, allow_destroy: true

  validates :title, presence: true, length: { maximum: 50 }
  validates :post, presence: true
end
