class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user
  validates_presence_of :status, :user_id

  # Need to test these through request specs manually
  scope :upvotes, -> { where(status: 1) }
  scope :downvotes, -> { where(status: 0) }
end
