require 'rails_helper'

RSpec.describe 'Add new Food form', type: :feature do
  before :each do
    @user = User.create(name: 'User name', email: 'email@test.com', password: '123456')

    sign_in @user
    visit new_food_path
  end

  scenario 'User shoul create a new food' do
    fill_in 'Name', with: 'Food name'
    fill_in 'Quantity', with: '10'
    fill_in 'Price', with: '10.0'
    click_button 'Create Food'
    expect(page).to have_content('Foods List')
  end
end
