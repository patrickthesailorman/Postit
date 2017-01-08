class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true
  validates :user_id, presence: true
  acts_as_votable
  def author
    user.username
  end
  def votes
    self.get_upvotes.size - self.get_downvotes.size
  end
end
