class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def image
  end
end
