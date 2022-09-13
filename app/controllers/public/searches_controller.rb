class Public::SearchesController < ApplicationController
  def search
    @events = Event.looks(params[:search], params[:word])
  end
end
