class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def check_user_id(id)
    id == current_user.id
  end

end
