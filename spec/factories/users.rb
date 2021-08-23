FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Mande_#{n}" }
    sequence(:email) { |n| "mande_#{n}@mande.com" }
    password { '12345678' }
    profile_photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_uploads/mande.jpg") }
    bike_photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/test_uploads/mande.jpg") }
    interests {'#birdwatching #sushi #sleep #eat' }
  end
end
