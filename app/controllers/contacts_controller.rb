class ContactsController < ApplicationController
  def new
    @contact = ContactMessage.new
  end

  def create
    @contact = ContactMessage.new(contact_params)
    if @contact.save
      redirect_to new_contact_path, notice: "Thank you! Your message has been sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_message).permit(:name, :email, :subject, :message)
  end
end
