class UsersController < ApplicationController
  def show
    @user = User.find_by!(uuid: params[:uuid])

    render json: {
      uuid: @user.uuid,
      name: @user.name,
      email: @user.email,
    }
  end
end
