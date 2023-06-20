# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

# Create businesses
Business.destroy_all
User.destroy_all
Review.destroy_all

# 10.times do |i|
#   puts "creating..."
#   business = Business.new(
#     name: Faker::Company.unique.name,
#     address: london_address.sample,
#     email: Faker::Internet.unique.email,
#     phone_number: Faker::PhoneNumber.unique.phone_number,
#     category: ['Hotel', 'Restaurant', 'Cafe', 'Bar', 'Resort'].sample,
#     size: ["1-10 employees", "11-50 employees", "51-100 employees"].sample,
#     business_hours: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
#     description: Faker::Restaurant.description
#   )
#   file = URI.open(Faker::LoremFlickr.image(size: "300x300", search_terms: ['bar']))
#   business.photo.attach(io: file, filename: "business_#{i}.png", content_type: "image/png")
#   business.save
#   puts "#{business.id} has been created"
# end

  puts "creating 25 businesses"

  business_1 = Business.create!(
    name: "Well & Bucket",
    address: "143 Bethnal Grn Rd, London E2 7DG",
    email: "info@wellandbucket.com",
    phone_number: "0203 664 6454",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 12am",
    description: "Dripping in cool and sophistication, we are the standing definition of what was old, always becomes new again. Situated in the heart of Shoreditch and serving delicious food with a host of classic lagers, craft beers, premium wines & spirits. Our shabby-chic exterior has everything you need for a memorable time once you step inside."
  )

  business_1.photo.attach(io: File.open(Rails.root.join("app/assets/images/Well&Bucket.jpg")), filename: "Well&Bucket.jpg", content_type: 'image/jpg')

  puts "business created"

  business_2 = Business.create!(
    name: "Williams Ale & Cider House",
    address: "22-24 Artillery Ln, London E1 7LS",
    email: "info@williamsspitalfields.com",
    phone_number: "020 7247 5163",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11pm",
    description: "The Williams is an East London boozer, tucked between the busy City and the artistic Spitalfields. We pride ourselves on our extensive ale and cider collection and our delicious, seasonal menu."
  )

  business_2.photo.attach(io: File.open(Rails.root.join("app/assets/images/WilliamsAle&CiderHouse.jpg")), filename: "WilliamsAle&CiderHouse.jpg", content_type: 'image/jpg')

  puts "business created"

  business_3 = Business.create!(
    name: "The Kings Arms",
    address: "11a Buckfast Street, London, E2 6EY",
    email: "elvis@thekingsarmspub.com",
    phone_number: "020 7729 2627",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11:30pm",
    description: "Relaxed and stylish modern pub serving guest ales and local craft beers, plus simple bar snacks."
  )

  business_3.photo.attach(io: File.open(Rails.root.join("app/assets/images/TheKingsArms.jpg")), filename: "TheKingsArms.jpg", content_type: 'image/jpg')

  puts "business created"

  business_4 = Business.create!(
    name: "The Royal Oak",
    address: "44 Tabard St, London SE1 4JU",
    email: "enquiries@royaloaklondon.co.uk",
    phone_number: "02073577173",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11pm",
    description: "James and the team would like to welcome you to The Royal Oak, a brick built Victorian pub set in the heart of Borough, London. Nestled on the corner, London high-rises have sprung up around our charming boozer, leaving it an untouched homage to a time when pubs were a place to go for a quiet pint after work, or to put the world to rights with friends."
  )

  business_4.photo.attach(io: File.open(Rails.root.join("app/assets/images/RoyalOak.jpg")), filename: "RoyalOak.jpg", content_type: 'image/jpg')

  puts "business created"

  business_5 = Business.create!(
    name: "Waxy O'Connor's London",
    address: "14-16 Rupert St, London W1D 6DD",
    email: "GMlondon@waxyoconnors.co.uk",
    phone_number: "02072870255",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 12am",
    description: "Receive a warm Irish welcome at the award-winning Waxy O’Connor’s, London’s biggest and best Irish bar. Located on Rupert Street at the edge of Soho, it’s a labyrinth of four unique bars over six levels, each with its own atmosphere and personality, as well as the famous Waxy’s tree found at the heart of the pub. There’s something for everyone at Waxy’s!"
  )

  business_5.photo.attach(io: File.open(Rails.root.join("app/assets/images/WaxyConnor.jpg")), filename: "WaxyConnor.jpg", content_type: 'image/jpg')

  puts "business created"

  business_6 = Business.create!(
    name: "The Black Horse",
    address: "6 Rathbone Pl, London W1T 1HL",
    email: "contact@theblackhorselondon.com",
    phone_number: "0203 582 4137",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11:30pm",
    description: "The Black Horse is the perfect marriage between traditional & modern, featuring a classic London pub downstairs and a sleek, speakeasy-style cocktail bar upstairs. Downstairs you find a host of classic lagers & craft beers with premium wines & spirits. Step upstairs into our secluded cocktail bar for some of the very best cocktails in Soho, if not London!"
  )

  business_6.photo.attach(io: File.open(Rails.root.join("app/assets/images/TheBlackHorse.jpg")), filename: "TheBlackHorse.jpg", content_type: 'image/jpg')

  puts "business created"

  business_7 = Business.create!(
    name: "Spit and Sawdust",
    address: "21 Bartholomew St, London SE1 4AL",
    email: "info@spitandsawdust.pub",
    phone_number: "02072070909",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "4pm - 11pm",
    description: "Rotating craft beers, classic British pies & lots of gin & whiskey in a restored 1850s building."
  )

  business_7.photo.attach(io: File.open(Rails.root.join("app/assets/images/SpitAndSawdust.jpg")), filename: "SpitAndSawdust.jpg", content_type: 'image/jpg')

  puts "business created"

  business_8 = Business.create!(
    name: "The Clachan",
    address: "34 Kingly St, Greater, Carnaby, London W1B 5QH",
    email: "contact@support.nicholsonspubs.co.uk",
    phone_number: "02074940834",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11:30pm",
    description: "The Clarence is conveniently located amongst the hustle and bustle of Piccadilly, a short walk from Leicester Square, Regent Street, Berkeley Square Gardens, and only a 2 minute walk from Green Park Underground Station, or 8 minutes from Piccadilly Circus underground Station."
  )

  business_8.photo.attach(io: File.open(Rails.root.join("app/assets/images/TheClachan.jpg")), filename: "TheClachan .jpg", content_type: 'image/jpg')

  puts "business created"

  business_9 = Business.create!(
    name: "Coach and Horses",
    address: "2 Old Compton St, London W1D 4TA",
    email: "CoachHorsesSoho@shepherd-neame.co.uk",
    phone_number: "02077344986",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "12pm - 11pm",
    description: "ocated in the heart of London’s Theatreland on the corner of Old Compton Street and Charing Cross Road, it’s the perfect choice for pre-theatre drinks, or to take a break while exploring the capital’s cultural attractions."
  )

  business_9.photo.attach(io: File.open(Rails.root.join("app/assets/images/CoachAndHorses.jpg")), filename: "CoachAndHorses.jpg", content_type: 'image/jpg')

  puts "business created"

  business_10 = Business.create!(
    name: "The Nags Head, Covent Garden",
    address: "10 James St, London WC2E 8BT",
    email: "NagsHead.CoventGarden@mcmullens.co.uk",
    phone_number: "0207 836 4678",
    category: "Pub",
    size: "11-50 employees",
    business_hours: "11am - 11pm",
    description: "Located right at the heart of London’s Covent Garden, opposite the London Underground tube, The Nag’s has been a McMullen pub since 1927. For more information about our pub, menus, and function room take a look at our website."
  )

  business_10.photo.attach(io: File.open(Rails.root.join("app/assets/images/TheNagsHead.jpg")), filename: "TheNagsHead.jpg", content_type: 'image/jpg')

  puts "business created"

  business_11 = Business.create!(
    name: "Big Easy Restaurant - Canary Wharf",
    address: "Crossrail Pl, London E14 5AR",
    email: "bluewater@bigeasy.co.uk",
    phone_number: "02045801172",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "12pm - 12am",
    description: "Our biggest restaurant (so far), Big Easy Canary Wharf brings our laid-back Bar.B.Q style to the famous skyscrapers of London’s business district, complete with live music, home-style cooking and – of course – plenty of fresh East Coast lobster. Our spectacular 150-seat sun-drenched terrace is a rare alfresco space in Canary Wharf, open year-round."
  )

  business_11.photo.attach(io: File.open(Rails.root.join("app/assets/images/BigEasy.jpeg")), filename: "WBigEasy.jpeg", content_type: 'image/jpeg')

  puts "business created"

  business_12 = Business.create!(
    name: "Midpoint Restaurant",
    address: "3, Anchor Iron Wharf, Ballast Quay, London SE10 9GL",
    email: "info@midpointrestaurant.co.uk",
    phone_number: "02082930377",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "10am - 11pm",
    description: "Midpoint Restaurant in Greenwich offers the finest authentic Turkish food. We cook everything using the highest quality ingredients and serve to you with a beautiful smile. Turkish food has long been hailed as one of the most flavoursome in the world. At Midpoint, we specialise in bringing you the unique culinary delights of Turkish cuisine."
  )

  business_12.photo.attach(io: File.open(Rails.root.join("app/assets/images/Midpoint.jpg")), filename: "Midpoint.jpg", content_type: 'image/jpg')

  puts "business created"

  business_13 = Business.create!(
    name: "No. Fifty Cheyne",
    address: "50 Cheyne Walk, London SW3 5LR",
    email: "info@fiftycheyne.com",
    phone_number: "02073768787",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "12pm -11pm",
    description: "Standing at the heart of Old Chelsea, Iain Smith leads the way as Executive Head Chef, creating a constantly evolving menu using the finest British ingredients centred around a calescent open grill. Our wine lists have been carefully curated to be exquisite yet at exceptional value."
  )

  business_13.photo.attach(io: File.open(Rails.root.join("app/assets/images/Fifty.jpg")), filename: "Fifty.jpg", content_type: 'image/jpg')

  puts "business created"

  business_14 = Business.create!(
    name: "Ottolenghi Chelsea",
    address: "261 Pavilion Rd, London SW1X 0BP",
    email: "CHELSEA@OTTOLENGHI.CO.UK",
    phone_number: "02038242818",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "8am - 7pm",
    description: "Over 20 years, we have become a proud family of delis and restaurants, with four Ottolenghi delis in Notting Hill, Islington, Chelsea, and Marylebone, as well as three restaurants - Ottolenghi Spitalfields, NOPI & ROVI. In all our locations you’ll find vibrant food, low intervention wines, and warm hospitality."
  )

  business_14.photo.attach(io: File.open(Rails.root.join("app/assets/images/Ottolenghi.jpg")), filename: "Ottolenghi.jpg", content_type: 'image/jpg')

  puts "business created"

  business_15 = Business.create!(
    name: "Jinjuu Soho",
    address: "15 Kingly St, Carnaby, London W1B 5PS",
    email: "admin@babbogroup.co.uk",
    phone_number: "07393900997",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "12pm - 11PM",
    description: "Jinjuu, meaning pearl, is a premier modern Korean bar and restaurant in the centre of London. Fusing traditional influences with Korean pop youth culture, our brand is vibrant and energetic."
  )

  business_15.photo.attach(io: File.open(Rails.root.join("app/assets/images/Jinjuu.jpeg")), filename: "Jinjuu.jpeg", content_type: 'image/jpeg')

  puts "business created"

  business_16 = Business.create!(
    name: "Blandford Comptoir",
    address: "1 Blandford St, London W1U 3DA",
    email: "info@blandford-comptoir.co.uk",
    phone_number: "02079354626",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "12pm - 10pm",
    description: "The restaurant is a community hub, with Xavier and his team inviting diners and local residents to contribute their thoughts and suggestions for the ever-evolving wine list. Open Tuesday to Saturday from 12-10pm, Blandford Comptoir’s relaxed and informal atmosphere appeals to Marylebone dwellers and workers, as well as those from across the Capital in search of great food and wine."
  )

  business_16.photo.attach(io: File.open(Rails.root.join("app/assets/images/BlandfordComptoir.jpeg")), filename: "BlandfordComptoir.jpeg", content_type: 'image/jpeg')

  puts "business created"

  business_17 = Business.create!(
    name: "Sunday in Brooklyn",
    address: "98 Westbourne Grove, London W2 5RU",
    email: "info@sundayinbk.co.uk",
    phone_number: "02076301060",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "9am - 10pm",
    description: "The essence behind the restaurant is in its name: Sunday in Brooklyn. Everyone has their day. Ours was Sunday. We’ve taken our favourite day of the week, a day of comfort, adventures, and family, and made it the mission of Sunday. We care deeply about what and who we serve. This is at the heart of Sunday in Brooklyn."
  )

  business_17.photo.attach(io: File.open(Rails.root.join("app/assets/images/SundayBrooklyn.jpg")), filename: "SundayBrooklyn.jpg", content_type: 'image/jpg')

  puts "business created"

  business_18 = Business.create!(
    name: "Mildreds Kings Cross",
    address: "200 Pentonville Rd, London N1 9JP",
    email: "hello@mildreds.co.uk",
    phone_number: "02072789422",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "9am - 11pm",
    description: "In 1988, when Soho was still edgy, the very first Mildreds opened on Greek Street, Soho. Back then vegetarian restaurants were still stuck in a 60s vibe – doling out ‘worthy’ brown food into earthenware pottery placed on pine tables. The whole thing felt dated, or so it seemed to us. Our aim was to open a restaurant serving good value, fresh and colourful, international vegetarian food."
  )

  business_18.photo.attach(io: File.open(Rails.root.join("app/assets/images/Mildreds.jpg")), filename: "Mildreds.jpg", content_type: 'image/jpg')

  puts "business created"

  business_19 = Business.create!(
    name: "Brasserie Blanc - Southbank",
    address: "9 Belvedere Rd, London SE1 8YL",
    email: "SOUTHBANK@BRASSERIEBLANC.com",
    phone_number: "02072028470",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "12pm - 11pm",
    description: "South of the river with all of the sass! We are delighted to welcome you to our gorgeous brasserie in the heart of the Southbank arts scene. Whether you are dropping by for a pre-theatre meal or popping in for a cheeky Happy Hour cocktail we look forwarding to seeing you!"
  )

  business_19.photo.attach(io: File.open(Rails.root.join("app/assets/images/Brasserie.jpg")), filename: "Brasserie.jpg", content_type: 'image/jpg')

  puts "business created"

  business_20 = Business.create!(
    name: "Megan's Clapham Old Town",
    address: "55-57 The Pavement, London SW4 0JQ",
    email: "hello@megans.co.uk",
    phone_number: "02034680215",
    category: "Restaurant",
    size: "11-50 employees",
    business_hours: "8:30am - 11pm",
    description: "We are a small, independently-owned, dog friendly spot, with homely & welcoming service. Our menu & interiors are loosely Mediterranean, making you feel as though you have been transported somewhere much sunnier. Open for brunch, lunch, dinner & cocktails all day everyday."
  )

  business_20.photo.attach(io: File.open(Rails.root.join("app/assets/images/Megan.jpg")), filename: "Megan.jpg", content_type:'image/jpg')

  puts "business created"

  business_21 = Business.create!(
    name: "Photobookcafe",
    address: "4 Leonard Circus, London EC2A 4DQ",
    email: "INFO@PHOTOBOOKCAFE.CO.UK",
    phone_number: "Email us",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "10am - 9pm",
    description: "We are a Community Cafe & Bar, Gallery & PhotoBook Library based on Leonard Circus in Shoreditch, London. Established in 2019 by Rapid Eye Darkroom, PBC was built on a passion for photo books, exhibitions and photography, as well as a love of food and drink."
  )

  business_21.photo.attach(io: File.open(Rails.root.join("app/assets/images/Photocaf.jpg")), filename: "Photocaf.jpg", content_type: 'image/jpg')

  puts "business created"

  business_22 = Business.create!(
    name: "Catalyst",
    address: "48 Grays Inn Rd, Chancery Ln, London WC1X 8LT",
    email: "contact@catalyst.cafe",
    phone_number: "02072428777",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "8am - 5pm",
    description: "A menu focused on classic coffee shop beverages with cocktails & cafe fare in a contemporary space."
  )

  business_22.photo.attach(io: File.open(Rails.root.join("app/assets/images/Catalyst.jpg")), filename: "Catalyst.jpg", content_type: 'image/jpg')

  puts "business created"

  business_23 = Business.create!(
    name: "Lantana",
    address: "44-46 Southwark St, London SE1 1UN",
    email: "site.londonbridge@lantanagroup.co.uk",
    phone_number: "02074032633",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "8am - 9pm",
    description: "Lantana London Bridge is our newest café south of the river on the doorstep of our favourite foodie hub, Borough Market. We have lovingly restored many of the 19th century features to create a large, open dining room set over two floors where diners can enjoy our signature dishes as well as some new additions as well as our famous brunch."
  )

  business_23.photo.attach(io: File.open(Rails.root.join("app/assets/images/Lantana.jpg")), filename: "Lantana.jpg", content_type: 'image/jpg')

  puts "business created"

  business_24 = Business.create!(
    name: "Terry's Cafe London",
    address: "158 Great Suffolk St, London SE1 0DT",
    email: "info@terryscafe.co.uk",
    phone_number: "02074079358",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "7:30am - 4:30pm",
    description: "All our food is cooked on the premises to our family’s recipes. It’s a thoroughly British affair. If you’re after a traditional English cafe serving honest, unpretentious, good-value food combined with friendly service, then look no further."
  )

  business_24.photo.attach(io: File.open(Rails.root.join("app/assets/images/Terry.jpg")), filename: "Terry.jpg", content_type: 'image/jpg')

  puts "business created"

  business_25 = Business.create!(
    name: "Briki",
    address: "67 Exmouth Market, London EC1R 4QL",
    email: "briki@ya2.co.uk",
    phone_number: "02072788745",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "7:30am - 8pm",
    description: "Briki is a deli and coffee brewery offering new, alternative choices with traditional recipes and quality coffee. Briki is housed in a brand new building, with glazed frontage on both sides of the building, overlooking the market and a bustling London intersection."
  )

  business_25.photo.attach(io: File.open(Rails.root.join("app/assets/images/Briki.jpg")), filename: "Briki.jpg", content_type: 'image/jpg')

  puts "business created"

  business_26 = Business.create!(
    name: "England's Lane",
    address: "2 England's Ln, Belsize Park, London NW3 4TG",
    email: "hello@englandslanecafe.com",
    phone_number: "02074831410",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "7:30am - 5:30pm",
    description: "North London’s finest café & restaurant, serving the best Antipodean-inspired food in a beautiful corner location on England’s Lane, Belsize Park."
  )

  business_26.photo.attach(io: File.open(Rails.root.join("app/assets/images/EnglandsLane.jpg")), filename: "EnglandsLane.jpg", content_type: 'image/jpg')

  puts "business created"

  business_27 = Business.create!(
    name: "The Pavilion Cafe",
    address: "Charlton Way, London SE10 8QY",
    email: "greenwichpark@benugo.com",
    phone_number: "02083052896",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "8:30am - 5pm",
    description: "You'll find the recently refurbished Pavilion Café at the top of the hill by the Royal Observatory. Built in 1906 this octagonal building is topped by a dove-cot with a weather vane showing Nelson looking through his telescope. In fine weather make the most of the large garden at the front and rear."
  )

  business_27.photo.attach(io: File.open(Rails.root.join("app/assets/images/Pavillion.jpg")), filename: "Pavillion.jpg", content_type: 'image/jpg')

  puts "business created"

  business_28 = Business.create!(
    name: "Crumpets",
    address: "82 Buckingham Gate, London SW1E 6PD",
    email: "coffee@crumpetscafe.com",
    phone_number: "07825107489",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "7am - 3pm",
    description: "Street food specials from a different part of the world each day. Specialist in Sri Lankan Food | Sri Lankan Cookery Classes & Private Dining. Ask about Office Lunches and our Hospitality Catering Supply."
  )

  business_28.photo.attach(io: File.open(Rails.root.join("app/assets/images/Crumpets.jpg")), filename: "Crumpets.jpg", content_type: 'image/jpg')

  puts "business created"

  business_29 = Business.create!(
    name: "Boxcar Baker & Deli",
    address: "7A Wyndham Pl, London W1H 1PN",
    email: "info@boxcar.co.uk",
    phone_number: "02030067000",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "8am - 5pm",
    description: "Welcome to Boxcar, two local Marylebone favourites. We're delighted to let you know that our new Bar & Grill is now open. Our venues are dog friendly."
  )

  business_29.photo.attach(io: File.open(Rails.root.join("app/assets/images/Boxcar.jpg")), filename: "Boxcar.jpg", content_type: 'image/jpg')

  puts "business created"

  business_30 = Business.create!(
    name: "Java Whiskers Cat Café Marylebone",
    address: "105 Great Portland St, London W1W 6QF",
    email: "info@javawhiskers.co.uk",
    phone_number: "Contact us via email",
    category: "Cafe",
    size: "1-10 employees",
    business_hours: "10am - 8pm",
    description: "Do you love cats? And do you love coffee too? At our café, you can enjoy both! A unique experience enhancing both the cats’ and guests’ well-being. Together with the public and our partners, we wish to find forever homes for homeless cats, while being a relaxing haven for our guests to ‘paws’ and enjoy in an otherwise busy world."
  )

  business_30.photo.attach(io: File.open(Rails.root.join("app/assets/images/Java.jpg")), filename: "Java.jpg", content_type: 'image/jpg')

  puts "business created"


  puts "creating 10 users"

  user_1 = User.create!( #As a User model is held by Devise, bio and location need to be added separately.
    username: "Joseph",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_1.photo.attach(io: File.open(Rails.root.join("app/assets/images/joseph.jpeg")), filename: "joseph.jpeg", content_type: 'image/jpeg')

  user_1.update!(
    bio: "Master of all things events and hospitality! I'll take your special occasions to the next level, crafting unforgettable moments that will have guests talking about them for years to come.",
    location: "London"
  )
puts "user created"

  user_2 = User.create!(
    username: "Maram",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_2.photo.attach(io: File.open(Rails.root.join("app/assets/images/maram.jpeg")), filename: "maram.jpeg", content_type: 'image/jpeg')

  user_2.update!(
    bio: "Friendly front desk ninja with a talent for making everyone feel instantly at ease. From check-ins to check-outs, I'm here to make your stay as smooth and enjoyable as possible!",
    location: "London"
  )
  puts "user created"

  user_3 = User.create!(
    username: "Alex",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_3.photo.attach(io: File.open(Rails.root.join("app/assets/images/alex.jpg")), filename: "alex.jpg", content_type: 'image/jpg')

  user_3.update!(
    bio: "People-pleaser extraordinaire and hospitality aficionado. I'll go above and beyond to ensure every guest feels like a VIP, with personalized service and a touch of genuine warmth.",
    location: "London"
  )
  puts "user created"

  user_4 = User.create!(
    username: "Eli",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_4.photo.attach(io: File.open(Rails.root.join("app/assets/images/eli.jpeg")), filename: "eli.jpeg", content_type: 'image/jpeg')

  user_4.update!(
    bio: "Seasoned hotel guru who knows the ins and outs of creating a great guest experience. I've got the skills to juggle any challenge and keep the vibes high, all while rocking a big smile!",
    location: "London"
  )
  puts "user created"

  user_5 = User.create!(
    username: "Brett",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_5.photo.attach(io: File.open(Rails.root.join("app/assets/images/brett.jpg")), filename: "brett.jpg", content_type: 'image/jpg')

  user_5.update!(
    bio: "Passionate hospitality rockstar with a flair for making magic happen. From surprise upgrades to secret local recommendations, I'm here to sprinkle some extra sparkle into your stay!",
    location: "London"
  )
  puts "user created"

  user_6 = User.create!(
    username: "Wojciech",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_6.photo.attach(io: File.open(Rails.root.join("app/assets/images/watch.jpeg")), filename: "watch.jpeg", content_type: 'image/jpeg')

  user_6.update!(
    bio: "Experienced hospitality pro who thrives on making people smile. Whether it's serving up delicious drinks or helping guests find hidden gems in the city, I'm all about creating unforgettable moments.",
    location: "London"
  )
  puts "user created"

  user_7 = User.create!(
    username: "Tom",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_7.photo.attach(io: File.open(Rails.root.join("app/assets/images/tom.jpeg")), filename: "tom.jpeg", content_type: 'image/jpeg')

  user_7.update!(
    bio: "Hospitality fanatic always on the lookout for opportunities to create awesome experiences. Love making guests feel right at home and going the extra mile to ensure they have a blast!",
    location: "London"
  )
  puts "user created"

  user_8 = User.create!(
    username: "Luca",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_8.photo.attach(io: File.open(Rails.root.join("app/assets/images/luca.jpeg")), filename: "luca.jpeg", content_type: 'image/jpeg')

  user_8.update!(
    bio: "Adventure-seeking hospitality enthusiast always ready to sprinkle a dash of excitement into your stay. Whether it's arranging epic activities or sharing local hidden gems, I'm your go-to person for unforgettable experiences!",
    location: "London"
  )
  puts "user created"

  user_9 = User.create!(
    username: "Omesh",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_9.photo.attach(io: File.open(Rails.root.join("app/assets/images/omesh.jpeg")), filename: "omesh.jpeg", content_type: 'image/jpeg')

  user_9.update!(
    bio: "Hospitality superhero with a passion for creating positive vibes. From crafting the coziest rooms to whipping up delicious breakfasts, I'm here to make sure your stay is filled with happy memories and belly laughs.",
    location: "London"
  )
  puts "user created"

  user_10 = User.create!(
    username: "Oli",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_10.photo.attach(io: File.open(Rails.root.join("app/assets/images/oli.jpeg")), filename: "oli.jpeg", content_type: 'image/jpeg')

  user_10.update!(
    bio: "Adventure-seeking hospitality enthusiast always ready to sprinkle a dash of excitement into your stay. Whether it's arranging epic activities or sharing local hidden gems, I'm your go-to person for unforgettable experiences!",
    location: "London"
  )
  puts "10 users created created"

  puts "creating 30 reviews"

  businesses = Business.all
  users = User.all
  titles = ["Great Work Environment", "Excellent Team","I hated every second there", "Flexible Schedule", "Don't work there", "They never pay on time", "They don't pay fair", "Good money", "Free lunches and good management"].sample
  user_content = titles

  30.times do
    business = businesses.sample
    user = users.sample

  Review.create!(
    business: business,
    user: user,
    title: titles,
    content: user_content,
    recommended: (titles.include?("hated") || titles.include?("don't") || titles.include?("never")) ? false : true,
    job_title: ["Manager", "Bartender", "Waitstaff", "Chef"].sample,
    rating: (titles.include?("hated") || titles.include?("don't") || titles.include?("never")) ? rand(1..3) : rand(4..5),
    wage: rand(7.0..15.0),
    votes: rand(0..10),
  )
  puts "review created"
  end
