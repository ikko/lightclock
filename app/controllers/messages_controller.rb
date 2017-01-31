class MessagesController < ApplicationController

  skip_before_action :authenticate_user!


  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.request = request
    if @message.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path, notice: "Your form was succesfully submitted!"
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

end
