class Comment < ApplicationRecord
belongs_to :user
  belongs_to :post
  validates :content, presence: true
  validates :post_id, presence: true
  validates :user_id, presence:true

  def commenter
    user.username
  end
end
