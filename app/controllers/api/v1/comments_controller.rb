class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    if current_user.id == params[:user_id] && @comment.save
      json_response(@comment, :created)
    else
      json_response(@comment.errors, :unprocessable_entity)
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:body, :user_id, :recipe_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
