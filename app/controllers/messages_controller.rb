class MessagesController < ApplicationController

  skip_before_action :authenticate_user!


  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.request = request
    if @message.deliver
      open(URI::encode("http://light_clock_platform.herokuapp.com/client_profiles/add?name=#{&message.name}&email=#{@message.email}&organisation=#{@message.organisation}&phone=#{@message.phone}&research_subject=#{@message.research_subject}&timezone=#{@message.timezone}&to_be_contacted=#{@message.time}"))
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path, notice: "Your form was succesfully submitted!"
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

end
