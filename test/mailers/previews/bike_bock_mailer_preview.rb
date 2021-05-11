class BikeBockMailerPreview < ActionMailer::Preview
  def welcome_email
    BikeBockMailer.with(user: User.first).welcome_email
  end
end

# http://localhost:3000/rails/mailers => list of previews
# preview: http://localhost:3000/rails/mailers/bike_bock_mailer/welcome_email
