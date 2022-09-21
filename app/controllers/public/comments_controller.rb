class Public::CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comments = @event.comments.order(created_at: :desc)
    @comment = @event.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_event = @comment.event
    if @comment.save
      # 通知の作成
      @comment_event.create_notification_comment(current_user, @comment.id)
      redirect_to event_path(@event)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to event_path(params[:event_id])
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
