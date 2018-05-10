class Api::V1::RecipesController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_recipe, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]
  def index
    @recipes = Recipe.all
    json_response(@recipes)
  end

  def show
    json_response @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = @user
    if @recipe.save
      params['pictures_data'].each do |picture|
        @recipe.pictures.create!(file: picture)
      end if params.key?('pictures_data')
      json_response(@recipe, :created)
    else
      json_response(@recipe.errors, :unprocessable_entity)
    end
  end

  def update
    if @recipe.update(recipe_params)
      params['pictures_data'].each do |picture|
        @recipe.pictures.create!(file: picture)
      end if params.key?('pictures_data')
      head :no_content
    else
      json_response(@recipe.errors, :unprocessable_entity)
    end
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def recipe_params
    params.permit(:name, :description, ingredients: [], directions: [], pictures_data: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id]) if params.key?(:user_id)
  end
end
