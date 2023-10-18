class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(user_id: current_user.id)
    @recipe_foods = []
    recipes_ingredients(@recipes)
    @group_by_user = RecipeFood.joins(recipe: :user, food: :user)
      .where(users: { id: current_user.id })
      .group('foods.name, foods.price, foods.quantity, recipe_foods.food_id')
      .select('foods.name, foods.price, foods.quantity, SUM(recipe_foods.quantity) as total_quantity')
    @total_price = sum(@group_by_user)
    @count_ingredients = @count
  end

  def stock
    @total_food = Food.sum(:quantity, group: :name)
  end

  def recipes_ingredients(recipes)
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @recipe_foods << recipe_food
      end
    end
  end

  private

  def sum(ingredients)
    sum = 0
    @count = 0
    ingredients.each do |number|
      sum += if (number.total_quantity - number.quantity).negative?
               0
             else
               number.price * (number.total_quantity - number.quantity)
             end
      @count += 1
    end

    sum
  end
end
