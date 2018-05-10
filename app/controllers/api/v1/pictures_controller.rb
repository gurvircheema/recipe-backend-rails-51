class Api::V1::PicturesController < ApplicationController
  before_action :set_picture

  def destroy
    @picture.destroy
    head :no_content
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
