class Comment < ApplicationRecord
  include VoteCount
  belongs_to :user
  belongs_to :recipe
  has_many :votes, as: :votable
  validates_presence_of :body, :user_id, :recipe_id

  def as_json(options)
    super({
      methods: [:upvotes_count, :downvotes_count]
    }).merge(options)
  end
end
