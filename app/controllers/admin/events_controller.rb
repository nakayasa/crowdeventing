class Admin::EventsController < ApplicationController

  #before_action :authenticate_admin!

  def index
    @events = Event.where("date >= ?", DateTime.now).reorder(:date, :start_at)
    @user = current_user
    @genres = Genre.all
  end

  def past
    @events =  Event.where("date < ?", DateTime.now).reorder(:date, :start_at).reverse
    @user = current_user
    @genres = Genre.all
  end

  def show
    @event =Event.find(params[:id])
    @joins = Join.where(event_id: @event.id)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
     flash[:notice] = "イベントが修正されました。"
     redirect_to admin_event_path(@event.id)
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

end

