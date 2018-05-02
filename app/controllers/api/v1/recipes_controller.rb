class Api::V1::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all 
    json_response(@recipes)
  end

  def show
    @recipe = Recipe.find(params[:id])
    json_response @recipe
  end
end