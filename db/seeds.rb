# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

User.destroy_all
# Request.destroy_all

# user_1

1.times do
  new_user = User.new(
    name: "Luis",
    email: "luis7villasmil1+@gmail.com",
    password: "12345678",
    about_me: "To me it doesn’t matter whether it’s raining or the sun is shining or whatever: as long as I’m riding a bike, I know I’m the luckiest guy in the world. Cycling is my passion.",
    interests: "LANGUAGES SNOWBOARDING CLIMBING HIKING COOKING",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=935&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")
  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_1.jpeg'), filename: 'bike_1.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 1 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Industrial Berlin",
      short_description: "Combine your bike trip with a discovery tour of Berlin's industrial culture.
      Visit the backyard workshop where Siemens & Halske, a global corporation, began.
      Find out from where Berlin was once supplied with electricity, water and gas.
      This 24-kilometer route is dedicated to the remaining monuments, factories, power plants and substations that made it possible to turn Berlin into a vibrant metropolis in the first place.
      And yes, breweries were already part of real big city life back then.",
      number_of_people: '2',
      start_time: "12:00",
      end_time: "13:00",
      start_location: "Deutsches Technik museum",
      end_location: "Kraftwerk Berlin",
      difficulty: '2',
      available_dates: "13.04.2022, 14.03.2022, 18.04.2022, 25.04.2022, 09.05.2022, 23.05.2022, 13.06.2022, 26.06.2022, 18.07.2022, 16.07.2022, 13.08.2022, 29.08.2022")
  puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/deutsches_technik_museum.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://d2exd72xrrp1s7.cloudfront.net/www/000/1k3/1w/1w39xmc1bguji1p8z1qgjsxfj82ysh8mvw-uhi5702063/0?width=3072&height=2304&crop=&q=70')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://d2exd72xrrp1s7.cloudfront.net/www/000/1k3/1c/1ccf1rzzfhrw9a4zg08ori032yshew3r-uhi5702118/0?width=3072&height=2304&crop=&q=70')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_2

1.times do
  new_user = User.new(
    name: "Fiona",
    email: "fiona3schlender2+@gmail.com",
    password: "12345678",
    about_me: "I am a deltiologist or simply, a person who collects postcard and I absolutely love cooking. I can merrily state that my kitchen is my playground in every sense!",
    interests: "SCIENE POLITICS LITERATURE CONCERTS THEATRES EXHIBITIONS",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1600207438283-a5de6d9df13e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_2.jpeg'), filename: 'bike_2.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 2 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Nikolassee Route",
      short_description: "On the short round trip through the Steglitz-Zehlendorf district in the southwest of Berlin you can enjoy the peace and quiet of the Grunewald forest.
      Jump into the cool water at various bathing spots. Learn interesting facts about the beginnings of Berlin in the Museumsdorf Düppel.
      Take a trip back to the days of German division at Alliied Checkpoint Bravo Dreilinden.",
      number_of_people: "2",
      start_time: "12:00",
      end_time: "14:00",
      start_location: "Wannsee S-Bahn",
      end_location: "Wannsee S-Bahn",
      difficulty: "1",
      available_dates: "27.04.2022, 28.04.2022, 15.04.2022, 17.04.2022, 14.05.2022, 29.05.2022, 26.06.2022, 27.06.2022, 24.07.2022, 29.07.2022, 11.08.2022, 15.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/nikolassee_route.png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/Ausflug_Wannsee_0367_c_visitBerlin_Foto_Thomas_Kierok_web.jpg.webp?itok=LOteDloL')
    
    new_ride.photo_2.attach(io: image2, filename: "#{new_ride.title}_1", content_type: 'image/png')
    new_ride.photo_1.attach(io: image1, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_bleed_header_visitberlin_desktop_2x/private/image/Ausflug_MG_0384_c_visitBerlin_Foto_Thomas_Kierok_web.jpg.webp?h=1c9b88c9&itok=Orl632TS')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_3

1.times do
  new_user = User.new(
    name: "Eden",
    email: "eden9ooms8+@gmail.com",
    password: "12345678",
    about_me: "I love learning new languages. I am a fluent speaker of 4 languages and I want to learn a few more. At present, I am learning Spanish and German. And I enjoy cycling and swimming.",
    interests: "LITERATURE TRAVEL MUSIC CULTURE ARTS SKATEBORDING",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1508511267-5a04ee04ca95?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_3.jpeg'), filename: 'bike_3.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 3 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Along the Spree",
      short_description: "There is also a lot of water right at the heart of Berlin – just cycle along the banks of the river Spree.
      The ride starts at Potsdamer Platz and takes you past the Brandenburg Gate, Reichstag, Bundeskanzleramt, Bellevue Palace and other sights.
      The section along the Landwehr Canal is particularly beautiful.",
      number_of_people: "2",
      start_time: "14:00",
      end_time: "16:00",
      start_location: "Flottwell Berlin Hotel & Residenz am Park",
      end_location: "Kulturforum",
      difficulty: "1",
      available_dates: "28.04.2022, 15.05.2022, 29.05.2022, 12.06.2022, 19.06.2022, 10.07.2022, 17.07.2022, 15.08.2022, 22.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/along_the_river_spree.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/regierungsviertel51_DL_PPT_2.jpg.webp?itok=sYeJd9Af')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/brandenburger_tor_fruehling_650696492_gettyimages_sborisov.jpg.webp?itok=DdbLFtHJ')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_4

1.times do
  new_user = User.new(
    name: "Panitan",
    email: "panitan4punpuang0+@gmail.com",
    password: "12345678",
    about_me: "I take pleasure in listening to music. I listen to music every morning before I leave for work and when I return home every night. I also take pleasure in reading and travelling to new places.",
    interests: "PHILOSOPHY SCIENCE STARTUPS YOGA TRAVEL DJ",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1600481176431-47ad2ab2745d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_4.jpeg'), filename: 'bike_4.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 4 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Always follow the water",
      short_description: "If you still don’t believe us that Berlin is virtually by the seaside, you should do this bike ride through Köpenick.
        Cycling continuously along the riverbank is the nicest.
        Through Müggelheim and Grünau until the Dahme lakes bike path – there is a lot to discover on this ride.
        A highlight is the ferry trip from Grünau to Wendenschloss on a ferry which dates back to the period before the Second World War.",
      number_of_people: "5",
      start_time: "11:00",
      end_time: "13:00",
      start_location: "Akademie Berlin-Schmöckwitz",
      end_location: "Akademie Berlin-Schmöckwitz",
      difficulty: "1",
      available_dates: "17.04.2022, 18.04.2022, 24.04.2022, 15.05.2022, 30.05.2022, 12.06.2022, 20.06.2022, 17.07.2022, 31.07.2022, 21.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/always_follow_the_water.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/Mueggelturm_2018_Sonnenterrasse_c_Berliner_Mueggelturm_UG_Foto_Swen_Bernitz_DL_PPT_0.jpg.webp?itok=2TnIotUO')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_5

1.times do
  new_user = User.new(
    name: "Ronan",
    email: "ronant6kruithof3+@gmail.com",
    password: "12345678",
    about_me: "I am a bird-watching enthusiast. I love the outdoors and enjoy going for hikes during weekends. Also, I often spend time reading nature books and also keep digging information on the internet about birds.",
    interests: "ART ARCHITECTURE DESIGN MUSIC MEDIA TECH TRAVEL",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1570632267781-46f97c2a4f76?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_5.jpeg'), filename: 'bike_5.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 5 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Wannsee Cycle Route",
      short_description: "A classic bike ride, but always lovely – from the city centre to Wannsee.
      You’ll travel through the historical centre, 19th century neighbourhoods and the villa suburbs to Potsdam.
      On the way you’ll pass Gendarmenmarkt, Checkpoint Charlie, the Schöneberg Town Hall, the Free University and much more.
      Once you’ve reached your destination, treat yourself to a jump into Berlin’s second largest lake.",
      number_of_people: "5",
      start_time: "09:00",
      end_time: "13:00",
      start_location: "Schlossplatz",
      end_location: "Glienicker Bridge",
      difficulty: "1",
      available_dates: "17.04.2022, 18.04.2022, 10.04.2022, 11.04.2022, 13.05.2022, 19.05.2022, 18.06.2022, 14.06.2022, 27.07.2022, 28.07.2022, 15.08.2022, 10.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/wansee_cycle_route.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_bleed_header_visitberlin_desktop_2x/private/image/Pfaueninsel_c_BA_SteglitzZehlendf_Foto_Steven_Ritzer%20%286%29_0.jpg.webp?h=b2774bcf&itok=uZklHBJ7')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/Liebermann_Villa_c_Scholvien%20%2824%29_OCV_web.jpg.webp?itok=1ZJhUVEx')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_6

1.times do
  new_user = User.new(
    name: "Martina",
    email: "martina5guido9+@gmail.com",
    password: "12345678",
    about_me: "I enjoyed travelling the most. Yes, I am a wandering soul. Visiting new places, traveling new roads, trying new cuisines and learning about new cultures excites me!",
    interests: "SUSTAINABILITY POLITICS ECONOMY CLUBING ICE-DIPPING yoga travel",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1588453383063-37ea0b78f30f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_6.jpeg'), filename: 'bike_6.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 6 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Ride Through Reinickendorf",
      short_description: "The north of Berlin is also great for bicycle rides.
      In addition to Tegel Airport, Reinickendorf offers a lot of water and nature.
      You can get acquainted with Berlin’s oldest tree in Tegel Forest and cycle around Lake Tegel.",
      number_of_people: "4",
      start_time: "15:00",
      end_time: "16:30",
      start_location: "U-Bahnhof Borsigwerke",
      end_location: "U-Bahnhof Wittenau",
      difficulty: "3",
      available_dates: "11.04.2022, 29.04.2022, 15.05.2022, 16.05.2022, 27.06.2022, 30.06.2022, 14.07.2022, 26.07.2022, 14.08.2022, 16.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/bicycle_ride_through_reinickendorf.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/tegelersee14_c_visitBerlin_Foto_Dagmar_Schwelle_DL_PPT_1.jpg.webp?itok=FvdwLWHi')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://d2exd72xrrp1s7.cloudfront.net/www/000/1k4/1a/1azon53nuewbl6pt9aaqok7vw3al9o7bn-uhi10788341/0?width=3072&height=2304&crop=&q=70')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_7

1.times do
  new_user = User.new(
    name: "JC",
    email: "jc1gellidon2+@gmail.com",
    password: "12345678",
    about_me: "I love to write in my free time. I have tons of notebooks filled with plots, character sketches, and obviously some random doodles. I take delight in writing short stories about my experiences.",
    interests: "TRAVELING COOKING LANGUAGES FITNESS MEDITATION YOGA",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1601062138836-c90756d8dce9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_7.jpeg'), filename: 'bike_7.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 7 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Cycling Tour at Tiergarten",
      short_description: "The Tiergarten is Berlin’s green lung.
      In the middle of the city – between the Brandenburg Gate, Potsdamer Platz and the Victory Column – you can walk, lie in the sunbathing areas or bike around.
      In the park you can also visit monuments or the Café am Neuen See.",
      number_of_people: "2",
      start_time: "16:00",
      end_time: "18:00",
      start_location: "Nürnberger Straße 65, 10787",
      end_location: "Café am neuen See",
      difficulty: "4",
      available_dates: "20.03.2022, 17.04.2022, 29.04.2022, 12.05.2022, 15.05.2022, 16.06.2022, 17.06.2022, 11.07.2022, 14.07.2022, 17.08.2022, 21.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/cycling_tour_at_tiegarten.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_bleed_header_visitberlin_desktop_2x/private/image/Siegess%C3%A4ule_iStock_c_SHansche_DL_PPT_0.jpg.webp?h=31459d7b&itok=WmKgJ-cp')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_bleed_header_visitberlin_desktop_2x/private/image/Haus%20der%20Kulturen_c_Scholvien_DL_PPT_0.jpg.webp?h=96abc80e&itok=TgJtwhrp')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# user_8

1.times do
  new_user = User.new(
    name: "Joy",
    email: "joy0aragon6+@gmail.com",
    password: "12345678",
    about_me: "I am fond of dancing, it is both my hobby and passion. Sometimes even during the day, I play music on my phone and dance my heart out, even if its for just 5 minutes! Dance helps me relax.",
    interests: "COFEE TRAVEL VINTAGE NATURE CHESS WINDSURFING",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1592755219588-d4ff92a0d4de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_8.jpeg'), filename: 'bike_8.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 8 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Treptow-Köpenick",
      short_description: "The centre, north and south-west - the south-east is still missing.
      And it’s worth it too.
      Treptow-Köpenick is blessed with plenty of water.
      This bike ride takes you along the River Spree, past the Müggelsee lake, through the canals of “New Venice” and then to Erkner.
      The highlights of the route include Köpenick’s old town, Treptower Park and the Archenhold Observatory.
      Remember your swimsuits!",
      number_of_people: "4",
      start_time: "10:00",
      end_time: "14:00",
      start_location: "Treptower Park",
      end_location: "S-Bahn Erkner",
      difficulty: "1",
      available_dates: "19.05.2022, 22.05.2022, 14.06.2022, 24.06.2022, 17.07.2022, 15.07.2022, 11.08.2022, 30.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = File.open('app/assets/images/bike_ride_through_treptow_kopenick.png')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_content_image_medium_visitberlin_desktop_2x/private/image/mueggelsee10_c_visitBerlin_Foto_Dagmar_Schwelle_DL_PPT_0.jpg.webp?itok=aQl5KqLN')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.visitberlin.de/system/files/styles/visitberlin_bleed_header_visitberlin_desktop_2x/private/image/koepenickaltstadt01_c_visitBerlin_Foto_Dagmar_Schwelle_DL_PPT_0.jpg.webp?h=06f6671c&itok=6xn_2eMr')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

  # User_9

  1.times do
  new_user = User.new(
    name: "Christiana",
    email: "christiana2rivers5+@gmail.com",
    password: "12345678",
    about_me: "I enjoy singing, dancing, riding a bike; I like painting the most. It is a way for me to express myself, my feelings and mood not by words but through art, which is understood only by a few people.",
    interests: "SINGING DANCING NATURE YOGA ART FESTIVALS COOKING BAKING DJ",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1493666438817-866a91353ca9?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1649&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_9.jpeg'), filename: 'bike_9.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 9 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Altlandsberg to Buckow",
      short_description: "Bring your flip flops!
      This ride starts in the historic walled city of Altlandsberg and takes you through the pine forest east of Radebrück before venturing through multiple villages to get to Buckow.
      Garzau has a nice lake with a beach along the way, but the Schermützelsee in Buckow is where I would jump in.
      This trip is radweg the entire way and a relatively easy ride.
      Buckow also has several restaurants, parks, and a Kneipp area all within just a couple minutes of walking.",
      number_of_people: "5",
      start_time: "8:00",
      end_time: "14:00",
      start_location: "Schlossgut Altlandsberg",
      end_location: "Buckow",
      difficulty: "3",
      available_dates: "14.05.2022, 12.05.2022, 24.06.2022, 29.06.2022, 19.07.2022, 25.07.2022, 11.08.2022, 29.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = URI.open('https://media.bikemap.net/routes/2989516/staticmaps/2989516_400x400.jpg')
    new_ride.photo_1.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = File.open('app/assets/images/buckow_1.png')
    new_ride.photo_2.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = File.open('app/assets/images/buckow_2.png')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

# User 10

  1.times do
  new_user = User.new(
    name: "Ben",
    email: "ben1engelsen4+@gmail.com",
    password: "12345678",
    about_me: "I love watching movies and yes! you can call me a CINEPHILE. I love watching action movies more than any other genre. I am a big fan of Tiger Shroff.",
    interests: "WINDSURFING MOVIES CINEMA JAZZ PHOTOGRAPHY TENNIS COFFEE COOKING TENNIS",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_10.jpeg'), filename: 'bike_10.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 10 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Templiner See",
      short_description: "Starting at the Potsdam Hauptbahnhof, this bike tour takes you south around the two lakes and back to the train station.
      It also includes the town of Caputh where Albert Einstein had his summer residence and a lovely restaurant on the water with outdoor seating.
      There are also multiple playgrounds along the way for the little ones.",
      number_of_people: "5",
      start_time: "10:00",
      end_time: "14:00",
      start_location: "Potsdam Hauptbahnhof",
      end_location: "Potsdam Hauptbahnhof",
      difficulty: "3",
      available_dates: "12.05.2022, 22.05.2022, 24.06.2022, 19.06.2022, 10.07.2022, 23.07.2022, 09.08.2022, 20.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = URI.open('https://www.tagesspiegel.de/images/rund-um-den-schwielowsee/13511562/2-format43.png')
    new_ride.photo_1.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://upload.wikimedia.org/wikipedia/commons/5/54/Potsdam_view_from_above.jpg')
    new_ride.photo_2.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://img.fotocommunity.com/abendstimmung-am-templiner-see-1278beb1-82e4-4b47-baff-8e2379f5c60c.jpg?height=1080')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

  # User_11

  1.times do
  new_user = User.new(
    name: "Omid",
    email: "omid7armin2+@gmail.com",
    password: "12345678",
    about_me: "I like traveling a lot, and I plan to take a trip every year. Majorly, the trips have been within the national boundaries only but I have an interest in exploring and traveling to other nations as well. I am the wordl traveler.",
    interests: "EXPLORING DOGS TRAVEL DJ PHOTOGRAPHY CHESS READING COOKING",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1548142813-c348350df52b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=389&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_11.jpeg'), filename: 'bike_11.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 11 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Havelland-Radweg",
      short_description: "There are two different long distance bike routes.
      This one is the Havelland-Radweg, which does not closely follow the Havel river, but rather connects small villages and towns somewhat aside.
      Among them is Nauen, the city which became well-known because of its early twentieth century radio stations connecting the emperor's Germany with its colonies.
      Also you pass Ribbeck, which became famous for its pear tree through a poem by Theodor Fontane.",
      number_of_people: "2",
      start_time: "8:00",
      end_time: "18:00",
      start_location: "Spandau Hauptbahnhof",
      end_location: "Havelberg",
      difficulty: "5",
      available_dates: "13.05.2022, 27.05.2022, 14.06.2022, 24.06.2022, 17.07.2022, 25.07.2022, 11.08.2022, 30.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = URI.open('https://media.bikemap.net/routes/2322155/staticmaps/2322155_400x400.jpg')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://potsdamer-brandenburger-havelseen.de/tl_files/content/3spalten/image_rad_3.jpg')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://potsdamer-brandenburger-havelseen.de/tl_files/content/3spalten/image_rad_2.jpg')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

  # User_12

  1.times do
  new_user = User.new(
    name: "Jordan",
    email: "jordan9whitfield4+@gmail.com",
    password: "12345678",
    about_me: "Traveling is my passion. Whenever I have an opportunity to visit a new place, whether a village, city, mountain or seaside, I never miss it. It is so thrilling to see a new place and meet different kind of people.",
    interests: "TRAVELING ADVENTURES COOKING WINE PHOTOGRAPHY BOOKS ART EXHIBITIONS DJ",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_12.jpeg'), filename: 'bike_12.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 12 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Berlin Wall",
      short_description: "A double row of cobblestones traces the Berlin Wall’s route over 5.7 kilometres through the city centre.
      This tour from the East Side Gallery to Bernauer Strasse via Potsdamer Platz passes memorials, Berlin Wall remnants, former border watchtowers and documentary panels with photos and details of the area’s history.",
      number_of_people: "2",
      start_time: "10:00",
      end_time: "12:00",
      start_location: " East Side Gallery",
      end_location: "Potsdamer Platz",
      difficulty: "1",
      available_dates: "10.05.2022, 12.05.2022, 14.06.2022, 24.06.2022, 20.07.2022, 15.07.2022, 21.08.2022, 30.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = URI.open('https://www.berlin.de/binaries/asset/image_assets/4138048/ratio_2_1/1531212987/972x486/')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://www.fattiretours.com/uploads/7386/berlin%20wall%20bike%20tour%20hero-675x317.jpg')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('http://spinlister-blog.s3.amazonaws.com/2016/04/Berliner-Mauerweg-13.jpg')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end

  # User_13

  1.times do
  new_user = User.new(
    name: "Logan",
    email: "logan6weaver0+@gmail.com",
    password: "12345678",
    about_me: "I am a person who is positive about every aspect of life. There are many things I like to do, to see, and to experience. And I always wanted to be a great writer, like Victor Hugo.",
    interests: "DRAWING PAINTING COOKING GARDENING PHOTOGRAPHY TRAVELING RUNNING",
    last_seen: DateTime.now
    )
  puts "User not saved!"
    image = URI.open("https://images.unsplash.com/photo-1524250502761-1ac6f2e30d43?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80")
    new_user.profile_photo.attach(io: image, filename: "#{new_user.name}", content_type: "image/png")

  puts "User photo added!"

  # bike
    new_user.bike_photo.attach(io: File.open('app/assets/images/bike_13.jpeg'), filename: 'bike_13.jpeg', content_type: 'image/jpeg')
    new_user.save!
  puts "User 13 saved!"

  1.times do
    new_ride = Ride.new(
      title: "Berlin Wall South",
      short_description: "And because the Berlin Wall bike path offers so many varied and beautiful routes, we think that the path can appear twice in our list.
      This time we go south on the Sonnenallee - Schönefeld - Lichtenrade section: From Sonnenallee you’ll ride continuously along the Teltow Canal via Schöneberg to Lichtenrade.
      The path is brand new and very beautiful.",
      number_of_people: "2",
      start_time: "10:00",
      end_time: "12:00",
      start_location: "Sonnenallee S-bahn",
      end_location: "Potsdamer Platz",
      difficulty: "1",
      available_dates: "14.05.2022, 19.05.2022, 14.06.2022, 24.06.2022, 10.07.2022, 25.07.2022, 21.08.2022, 30.08.2022")
    puts "New ride not saved!"

    # photos
    image1 = URI.open('https://images.unsplash.com/photo-1441095119381-ce8d1e079f24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80')
    new_ride.photo_2.attach(io: image1, filename: "#{new_ride.title}_1", content_type: 'image/png')
    image2 = URI.open('https://images.unsplash.com/photo-1475452524438-d6a4a3f6fdc3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80')
    new_ride.photo_1.attach(io: image2, filename: "#{new_ride.title}_2", content_type: 'image/png')
    image3 = URI.open('https://www.lichtenrade-berlin.de/images/lichtenrade-berlin-maelzerei.jpg')
    new_ride.photo_3.attach(io: image3, filename: "#{new_ride.title}_3", content_type: 'image/png')

    new_ride.user = new_user
    new_ride.save!
  puts "Added 3 images!"

  end
end
