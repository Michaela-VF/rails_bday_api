class UsersController < ApplicationController
  def index
    # expose all the users with names and bod's
    users = User.all
    render json: users
  end

  def show
    # this will expose a specific user based on its :id
    user = User.find_by(id: params[:id])

    # error handling when book (:id) doesn't exist
    if user
      render json: user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    # create a new user with name and dob
    user = User.new(user_params)

    # error handling for invalid data
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def birthday
    user = User.find(params[:id])
    date = Date.parse(params[:date])

    render json: { result: user.birthday?(date) }
  end

    def age
      user = User.find(params[:id])
      date = Date.parse(params[:date])

      render json: { result: user.age(date) }
    end

  def next_birthday
    user = User.find(params[:id])
    date = Date.parse(params[:date])

    render json: { result: user.next_birthday(date) }
  end

  private

  def user_params
    params.require(:user).permit(:name, :dob)
  end
end
