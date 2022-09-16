class Public::UsersController < ApplicationController

  #before_action :authenticate_user!

  def index
    @events = Event.all
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
    joins = Join.where(user_id: @user.id).pluck(:event_id)
    #新しい日付順に並び替え
    @event_sort = Event.order(date: "DESC", start_at: "DESC")
    #Joinしたイベントを探す
    @join_events = @event_sort.find(joins)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def check
    @user = current_user
  end

  def delete
    @user = current_user
    @user.update(delete_status: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :affiliation, :employee_id, :body, :profile_image)
  end

end
