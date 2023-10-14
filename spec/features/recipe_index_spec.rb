require 'rails_helper'

RSpec.describe 'Visit recipes index page', type: :feature do
  before :each do
    @user = User.create(name: 'Nick Jhons', email: 'test@test.com', password: '123456')
    @recipe1 = Recipe.create(name: 'Pasta', user: @user, preparation_time: 15, cooking_time: 15,
                             description: 'description 1', public: true)
    @recipe2 = Recipe.create(name: 'Hamburguer', user_id: @user.id, preparation_time: 10, cooking_time: 15,
                             description: 'description 2', public: false)

    sign_in @user
    visit recipes_path
  end

  # it 'Should see your name after sign in' do
  #   expect(page).to have_content 'Welcome Nick Jhons'
  # end

  it 'Should see a list of recipes' do
    expect(page).to have_content 'Recipes'
    expect(page).to have_content 'Pasta'
    expect(page).to have_content 'Hamburguer'
  end

  it 'Should find a button or link to add a new recipe' do
    expect(page).to have_content 'Recipes'
    expect(page).to have_content 'New Recipe'
    expect(page).to have_selector('a')
  end

  it "When click on 'Add a new Recipe', should redirects to a form to add a new" do
    click_link 'New Recipe'
    expect(page).to have_current_path(new_recipe_path)
  end
end
