require 'rails_helper'

feature 'User search recipe' do
  scenario 'successfully' do
    user = User.create(email: 'lucas@exemplo.com', password: '123456')


    recipe_type = RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura',difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine, user: user,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path
    fill_in 'Busca por receita', with: 'Bolo de cenoura'
    click_on 'Buscar'

    expect(page).to have_content('Bolo de cenoura')
    expect(current_path).to eq search_path
    expect(page).to have_content('1 recipe encontrada')
  end

  scenario 'not find' do
    recipe_type = RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path
    fill_in 'Busca por receita', with: 'Feijoada'
    click_on 'Buscar'

    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).to have_content('Nenhuma receita encontrada')
    expect(current_path).to eq search_path
  end

  scenario 'find all' do
    user = User.create(email: 'lucas@exemplo.com', password: '123456')

    recipe_type = RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine, user: user,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    Recipe.create(title: 'Bolo de maracuja', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine, user: user, 
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path
    fill_in 'Busca por receita', with: 'Bolo'
    click_on 'Buscar'

    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de maracuja')
    expect(page).to have_content('2 recipes encontradas')
    expect(current_path).to eq search_path
  end
end