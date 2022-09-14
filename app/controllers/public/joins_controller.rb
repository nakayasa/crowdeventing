class Public::JoinsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    join = current_user.joins.new(event_id: @event.id)
    join.save
    @event.create_notification_join(current_user) #通知
    redirect_to event_path(@event)
  end

  def destroy
    event = Event.find(params[:event_id])
    join = current_user.joins.find_by(event_id: event.id)
    join.destroy
    redirect_to event_path(event)
  end

end