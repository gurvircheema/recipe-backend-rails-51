module VoteCount
  extend ActiveSupport::Concern

  included do
    def upvotes_count
      votes.upvotes.count
    end

    def downvotes_count
      votes.downvotes.count
    end
  end
end
