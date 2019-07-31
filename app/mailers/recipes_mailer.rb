class RecipesMailer < ApplicationMailer

  def send_recipe(recipe_id, author, to, msg)
    @recipe = Recipe.find(recipe_id)
    @author = author
    @to = to
    @msg = msg

    mail( to: to,  subject: 'Envio de receita')
  end  
end  