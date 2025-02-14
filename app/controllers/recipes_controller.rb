class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    return redirect_to @recipe if @recipe.save

    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    render :new
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    return redirect_to @recipe if @recipe.update(recipe_params)

    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    render :edit
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:q]}%")
  end  

  def message
    id = params[:recipe_id].to_i
    recipe = Recipe.find(id)
    to = params[:to]
    from = params[:from]
    msg = params[:message]

    RecipesMailer.send_recipe(id, from, to, msg)
    flash[:notice] = "Mensagem enviada com sucesso!"
    redirect_to recipe
  end  

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :photo)
  end
end
