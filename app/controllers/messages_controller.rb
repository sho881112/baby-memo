class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @messages = pagy(Message.all, items: 10)
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'MEMO が記録されました。今日も子育ておつかれさまです♪'
      redirect_to @message
    else
      flash.now[:danger] = 'MEMO が記録されませんでした。おつかれが出ていないですか？'
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'MEMO が記録されました。今日も子育ておつかれさまです♪'
      redirect_to @message
    else
      flash.now[:danger] = 'MEMO が記録されませんでした。おつかれが出ていないですか？'
      render :edit
    end
  end

  def destroy
    @message.destroy

    flash[:success] = 'MEMO が削除されました。今日も子育ておつかれさまです♪'
    redirect_to messages_url
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :title)
  end
end