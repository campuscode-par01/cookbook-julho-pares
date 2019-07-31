require 'rails_helper'
  feature 'Visitor view recipe details' do
    scenario 'successfully' do
      #cria os dados necessários
      recipe_type = RecipeType.create(name: 'Sobremesa')
      user = User.create(email: 'lucas@exemplo.com', password: '123456')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de cenoura', 
                            recipe_type: recipe_type,
                            cuisine: cuisine, 
                            difficulty: 'Médio',
                            user: user,
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
  
    expect(RecipesMailer).to receive(:send_recipe).with(recipe.id, 'lucas', 'josy@exemplo.com', 'Josy segue receita de natal' )
    visit root_path
    click_on 'Bolo de cenoura'
    fill_in 'De', with: 'lucas'
    fill_in 'Para', with: 'josy@exemplo.com'
    fill_in 'Mensagem', with: 'Josy segue receita de natal'
    click_on 'Enviar receita'
    
    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content("Mensagem enviada com sucesso!")
   end
end
 