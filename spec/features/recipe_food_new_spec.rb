require 'rails_helper'

RSpec.describe 'New food for a especific recipe ', type: :feature do
  before :each do
    @user = User.create(name: 'User name', email: 'email@test.com', password: 'password123')
    @recipe = Recipe.create(name: 'My new recipe', user: @user, preparation_time: 15, cooking_time: 15,
                            description: 'description 1', public: true)
    @food = Food.create(name: 'Food name', user: @user, quantity: 1, measurement_unit: 'kg', price: 10.0)

    sign_in @user
    visit new_recipe_food_path(recipe_id: @recipe.id)
  end

  scenario 'User creates a new recipe' do
    fill_in 'Quantity', with: 12
    click_button 'Add Ingredient'
    expect(page).to have_content('Ingredient added successfully')
  end
end
