require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Baiana'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Baiana')
    expect(page).to have_content("Cozinha cadastrada com sucesso!")
  end

  scenario 'User register cuisine and must fill in name' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'name must be unic' do
    Cuisine.create(name: 'Arabe')
    
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'
    

    expect(page).to have_content('O nome deve ser único')
  end  

end