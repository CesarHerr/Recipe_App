class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.includes(:user).all
    @current_user = current_user
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.valid? && @food.save
      flash[:success] = 'Food has been added successfully'
      redirect_to foods_path
    else
      flash[:alert] = 'Food has not been added !!!'
      redirect_to new_food_path
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
