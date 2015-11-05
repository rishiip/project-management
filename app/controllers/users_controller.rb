class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:projects => [:todos]).select{ |user| user.id != current_user.id }

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @user = User.includes(:projects => [:todos]).find_by_id(params[:id])

    respond_to do |format|
      format.json
    end
  end
end
