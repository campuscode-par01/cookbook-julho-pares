require 'rails_helper'

feature 'User view list' do
  scenario 'successfully' do
    user = User.create(email: 'lucas@exemplo.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
    recipe_type: recipe_type, cuisine: cuisine,
    cook_time: 50,
    user: user,
    ingredients: 'Farinha, açucar, cenoura',
    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
   
    list = List.create(name: 'Natal', user: user)
    list_recipe =  ListRecipe.create(list: list, recipe: recipe)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@exemplo.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Minhas listas'
    click_on 'Natal'

    expect(page).to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de banana')
  end
end
