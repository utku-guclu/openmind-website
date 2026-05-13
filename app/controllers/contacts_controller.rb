class ContactsController < ApplicationController
  rate_limit to: 5, within: 1.hour, only: :create, by: -> { request.remote_ip },
             with: -> { redirect_to new_contact_path, alert: "Too many submissions. Please try again later." }

  def new
    @contact = ContactMessage.new
  end

  def create
    if params.dig(:contact_message, :website).present?
      redirect_to new_contact_path, notice: "Thank you! Your message has been sent."
      return
    end

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
