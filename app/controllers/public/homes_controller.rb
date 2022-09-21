class Public::HomesController < ApplicationController
  def top
    @event = Event.order("id").limit(4)
    @genres = Genre.all
    @eventnew = Event.new
  end

  def about
  end
end
