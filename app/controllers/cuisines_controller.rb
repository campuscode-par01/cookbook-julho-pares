class CuisinesController < ApplicationController

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      flash[:alert] = 'Cozinha cadastrada com sucesso!'
      redirect_to @cuisine
    else 
      render :new
    end  
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end