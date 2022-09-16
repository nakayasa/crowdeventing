class Public::EventsController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def new
    @event = Event.new
  end

  def create
    @genres = Genre.all
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @user = current_user
    @events = Event.all
    if @event.save
     flash[:notice] = "イベントが追加されました"
     redirect_to event_path(@event.id)
    else
     render :index
    end
  end

  def index
    @events = Event.where("date >= ?", DateTime.now).reorder(:date, :start_at)
    @event = Event.new
    @user = current_user
    @genres = Genre.all
  end

  def past
    @events =  Event.where("date < ?", DateTime.now).reorder(:date, :start_at).reverse
    @event = Event.new
    @user = current_user
    @genres = Genre.all
  end

  def show
    @event = Event.find(params[:id])
    @user = current_user
    @eventnew = Event.new
    #当該イベントへJoinされたIDを検索する
    @joins = Join.where(event_id: @event.id)
    @comment = Comment.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
     flash[:notice] = "イベントが修正されました。"
     redirect_to event_path(@event.id)
    else
     render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

private
  def event_params
    params.require(:event).permit(:name, :body, :genre_id, :date, :start_at, :end_at, :location, :cost, :recruit)
  end

  def correct_user
    @event = Event.find(params[:id])
    @user = @event.user
    redirect_to(events_path) unless @user == current_user
  end
end