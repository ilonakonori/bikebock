class BikeBockMailer < ApplicationMailer
  def welcome_email
    mail(
      from: "Bike Bock<info@bikebock.de>",
      to: params[:user].email,
      subject: 'Welcome to Bike Bock!') do |format|
      format.html { render 'welcome_email.html.erb' }
      format.text { render plain: 'welcome_email.text.erb' }
    end
  end
end
