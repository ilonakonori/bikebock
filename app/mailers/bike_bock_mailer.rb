class BikeBockMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(
      from: "Bike Bock<bikebock@bikebock.de>",
      to: @user.email,
      subject: 'Welcome to Bike Bock!') do |format|
        format.html { render 'welcome_email.html.erb' }
        format.text { render plain: 'welcome_email.text.erb' }
      end
  end
end
