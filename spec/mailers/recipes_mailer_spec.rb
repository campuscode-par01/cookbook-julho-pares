require 'rails_helper'

describe RecipesMailer do
  describe '#send_recipe' do
    it 'Send recipe' do
    user = User.create(email: 'lucas@exemplo.com', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50,
                            user: user,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      mail = RecipesMailer.send_recipe(recipe.id, 'Lucas', 'josy@exemplo.com', 'Josy segue receita de natal')
      
      expect(mail.to).to include 'josy@exemplo.com'
      expect(mail.body).to include 'Lucas enviou uma receita: Bolo de cenoura'
      expect(mail.body).to include 'Josy segue receita de natal'
    end
  end
end