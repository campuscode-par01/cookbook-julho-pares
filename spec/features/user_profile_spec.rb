require 'rails_helper'

feature 'User view profile' do
  scenario 'Successfully' do
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
    
    login_as(user, scope: :user)
    visit root_path
    click_on "Meu Perfil"

    expect(current_path).to eq profile_path
    expect(page).to have_content(user.email)
    expect(page).to have_content('Bolo de cenoura')
  end
end