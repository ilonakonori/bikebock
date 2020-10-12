# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

1.times do
  new_user = User.new(
    name: "Luis",
    email: "luis7villasmil1+@gmail.com",
    password: "123456",
    date_of_birth: "1987-02-15",
    about_me: "To me it doesn’t matter whether it’s raining or the sun is shining or whatever: as long as I’m riding a bike, I know I’m the luckiest guy in the world. Cycling is my passion."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=935&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Fiona",
    email: "fiona3schlender2+@gmail.com",
    password: "123456",
    date_of_birth: "1990-12-23",
    about_me: "I am a deltiologist or simply, a person who collects postcard and I absolutely love cooking. I can merrily state that my kitchen is my playground in every sense! "
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1600207438283-a5de6d9df13e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Eden",
    email: "eden9ooms8+@gmail.com",
    password: "123456",
    date_of_birth: "1993-10-01",
    about_me: "I love learning new languages. I am a fluent speaker of 4 languages and I want to learn a few more. At present, I am learning Spanish and German. I have a tutor to learn German. And I enjoy cycling and swimming."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1508511267-5a04ee04ca95?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Panitan",
    email: "panitan4punpuang0+@gmail.com",
    password: "123456",
    date_of_birth: "1982-03-08",
    about_me: "I take pleasure in listening to music. I listen to music every morning before I leave for work and when I return home every night. I also take pleasure in reading and travelling to new places."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1600481176431-47ad2ab2745d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Ronan",
    email: "ronant6kruithof3+@gmail.com",
    password: "123456",
    date_of_birth: "1988-08-20",
    about_me: "I am a bird-watching enthusiast. I love the outdoors and enjoy going for hikes during weekends. Also, I often spend time reading nature books and also keep digging information on the internet about birds in this region."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1570632267781-46f97c2a4f76?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Martina",
    email: "martina5guido9+@gmail.com",
    password: "123456",
    date_of_birth: "1993-11-30",
    about_me: "I enjoyed travelling the most. Yes, I am a wandering soul. Visiting new places, traveling new roads, trying new cuisines and learning about new cultures excites me! My dream is to cover all the countries, both small and big, before I turn 50!"
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1588453383063-37ea0b78f30f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "JC",
    email: "jc1gellidon2+@gmail.com",
    password: "123456",
    date_of_birth: "1985-05-11",
    about_me: "I love to write in my free time. I have tons of notebooks filled with plots, character sketches, and obviously some random doodles. I take delight in writing short stories about the experiences I encounter every day."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1601062138836-c90756d8dce9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end

1.times do
  new_user = User.new(
    name: "Joy",
    email: "joy0aragon6+@gmail.com",
    password: "123456",
    date_of_birth: "1994-01-18",
    about_me: "I am fond of dancing, it is both my hobby and passion. Sometimes even during the day, I play music on my phone and dance my heart out, even if its for just 5 minutes! Dance helps me relax as it invigorates my soul. I am a trained Bharatnatyam dancer."
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1592755219588-d4ff92a0d4de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")
    new_user.photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
    new_user.save!
  puts "User photo added!"
end
