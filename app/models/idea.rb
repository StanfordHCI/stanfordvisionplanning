class Idea < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :delete_all
  belongs_to :thredded_topic,  class_name: 'Thredded::Topic'
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
 

  def upvotes
    votes.where(value: 1).count
  end
  
  def downvotes
    votes.where(value: -1).count
  end
  
  def votes_value
    upvotes - downvotes
  end
end
