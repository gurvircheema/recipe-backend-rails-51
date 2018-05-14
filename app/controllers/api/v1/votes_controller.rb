class Api::V1::VotesController < ApplicationController
  before_action :find_votable

  def upvote
    @votable.votes.create(status: 1, user_id: vote_params[:user_id])
    json_response("Upvoted #{@votable.id}", :created)
  end

  def downvote
    @votable.votes.create(status: 0, user_id: vote_params[:user_id])
    json_response("Downvoted #{@votable.id}", :created)
  end

  private

  def find_votable
    klass = vote_params[:votable_type].capitalize.constantize
    @votable = klass.find(vote_params[:votable_id])
  end

  def vote_params
    params.require(:vote).permit(:votable_type, :votable_id, :user_id)
  end
end
