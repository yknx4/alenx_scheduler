class UsersController < ApplicationController
  def show
  end

  private
  def find_user
    @user = User.find_by(id: resource_id)
    redirect_to :root if @user.blank?
  end

  def resource_id
    params.permit(:id)[:id]
  end
end