require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    
    user = User.create(email: 'lucas@exemplo.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@exemplo.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Bem vindo lucas@exemplo.com'
    expect(page).not_to have_content 'Entrar'
  end
  scenario 'and sign out' do
    
    user = User.create(email: 'lucas@exemplo.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@exemplo.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).not_to have_content 'Bem vindo lucas@exemplo.com'
    expect(page).to have_content 'Entrar'
  end
end      