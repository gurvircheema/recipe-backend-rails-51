class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates_presence_of :body, :user_id, :recipe_id
end
