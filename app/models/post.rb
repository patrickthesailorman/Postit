class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true
  validates :user_id, presence: true
  def author
    user.username
  end
end
