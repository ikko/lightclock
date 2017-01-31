class ContactsController < ApplicationController

  skip_before_action :authenticate_user!


  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      open(URI::encode("http://light-clock-platform.herokuapp.com/thinker_profiles/add?name=#{@contact.name}&email=#{@contact.email}&expertise=#{@contact.expertise}&degree=#{@contact.degree}&website=#{@contact.website}&cv_url=#{@contact.cv_url}"))
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path, notice: "Your form was succesfully submitted!"
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

end
