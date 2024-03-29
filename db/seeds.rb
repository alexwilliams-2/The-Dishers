require 'uri'
require 'faker'
require 'open-uri'
require 'json'

Business.destroy_all
ChatUser.destroy_all
Chat.destroy_all
User.destroy_all
Review.destroy_all

api_key = ENV['GEOAPIFY_API_KEY']

brum_url = "https://api.geoapify.com/v2/places?categories=catering.bar,catering.pub,catering.cafe,catering.restaurant&filter=place:5120a11227befefdbf599d89f4d38a3e4a40f00101f9014a7a020000000000c0020692030a4269726d696e6768616d&limit=10&apiKey=#{api_key}"
brum_businesses_response = URI.open(brum_url).read
brum_businesses = JSON.parse(brum_businesses_response)

lpool_url = "https://api.geoapify.com/v2/places?categories=catering.bar,catering.pub,catering.cafe,catering.restaurant&filter=place:51f6285c8fc2d507c05979909e2287b44a40c00208e2031e77686f736f6e66697273743a6c6f63616c6974793a313031373530353437&lang=en&limit=10&apiKey=#{api_key}"
lpool_business_response = URI.open(lpool_url).read
lpool_businesses = JSON.parse(lpool_business_response)

cov_url = "https://api.geoapify.com/v2/places?categories=catering.bar,catering.restaurant,catering.cafe&filter=place:512e8c83caf050f8bf59b090a24e5c354a40f00101f901427a020000000000c00206920308436f76656e747279&lang=en&limit=10&apiKey=#{api_key}"
cov_businesses_response = URI.open(cov_url).read
cov_businesses = JSON.parse(cov_businesses_response)

manc_url = "https://api.geoapify.com/v2/places?categories=catering.bar,catering.restaurant,catering.cafe&filter=place:51d60053a21bdc01c0591f63b0ddcbb94a40f00101f901e03c020000000000c0020692030a4d616e63686573746572&lang=en&limit=10&apiKey=#{api_key}"
manc_businesses_response = URI.open(manc_url).read
manc_businesses = JSON.parse(manc_businesses_response)

glasgow_url = "https://api.geoapify.com/v2/places?categories=catering.bar,catering.restaurant,catering.cafe&filter=place:516cee43392c0011c0593f50b8533aee4b40f00103f9014ecaa90000000000920307476c6173676f77&lang=en&limit=10&apiKey=#{api_key}"
glasgow_business_response = URI.open(glasgow_url).read
glasgow_businesses = JSON.parse(glasgow_business_response)

# description_line_1 = "#{business['features']['properties']['name']} is a popular and friendly #{
# if business['features']['properties']['categories'].include?('catering.pub')
# 'Pub'
# elsif business['features']['properties']['categories'].include?('catering.bar')
#   'Bar'
# elsif business['features']['properties']['categories'].include?('catering.restaurant')
#   'Restaurant'
# elsif business['features']['properties']['categories'].include?('catering.cafe')
#   'Cafe'
# end
# } in the city of #{business['features']['properties']['city']}."

# description_line_2 = "Nestled amongs the other delights of #{business['features']['properties']['datasource']['raw']['addr:street']},
# #{business['features']['properties']['name']} is a popular destination for many #{ business['features']['properties']['categories'].include?('catering.pub') || business['features']['properties']['categories'].include?('catering.bar') ? "drinkers and revellers" : "tourists, locals and foodies"}."

# description_line_3 = "Offering a wide range of #{
# if business['features']['properties']['categories'].include?('catering.pub')
#  'classic lagers and homely food'
# elsif business['features']['properties']['categories'].include?('catering.bar')
#   'smart cocktails with a smooth, relaxing atmosphere'
# elsif  business['features']['properties']['categories'].include?('catering.restaurant')
#   'fantasatic food in a relaxing environment'
# elsif business['features']['properties']['categories'].include?('catering.cafe')
#   'caffeinated treats and homecooked snacks'
# end
# }, this is not a place you would want to miss out on. Please read on on more information from other Dishers who have experienced working at #{business['features']['properties']['name']} and see what they have to say."

# description = "#{description_line_1} \r #{description_line_2} \r #{description_line_3}"

puts "Creating Glesga businesses"

glasgow_businesses['features'].each do |business|
  Business.create!(
    name: business['properties']['name'],
    address: business['properties']['formatted'],
    email: business['properties']['datasource']['raw'].include?('email') ? business['properties']['datasource']['raw']['email'] : "#{business['properties']['name']}.outlook.com",
    phone_number: business['properties']['datasource']['raw'].include?('phone') ? business['properties']['datasource']['raw']['phone'] : "0121 532 #{Random.rand(100..999)}",
    size: "#{rand(0..25)} employees",
    business_hours: business['properties']['datasource']['raw']['opening_hours'] ? business['properties']['datasource']['raw']['opening_hours'] : 'Unknown Business Hours',
    description: "#{business['properties']['name']} is a popular #{
      if business['properties']['categories'].include?('catering.pub')
      'pub'
      elsif business['properties']['categories'].include?('catering.bar')
        'bar'
      elsif business['properties']['categories'].include?('catering.restaurant')
        'restaurant'
      elsif business['properties']['categories'].include?('catering.cafe')
        'cafe'
      end
      } in the city of #{business['properties']['city']}. \n\n Located on #{
        if business['properties']['datasource']['raw']['addr:street']
            "#{business['properties']['datasource']['raw']['addr:street']}"
        else
          'a bustling street'
        end
        }, #{business['properties']['name']} offers a wide range of #{
         if business['properties']['categories'].include?('catering.pub')
          'classic lagers and homely food'
         elsif business['properties']['categories'].include?('catering.bar')
           'smart cocktails and a smooth, relaxing atmosphere'
         elsif  business['properties']['categories'].include?('catering.restaurant')
           'fantasatic food in a relaxing environment'
         elsif business['properties']['categories'].include?('catering.cafe')
           'caffeinated treats and homecooked snacks'
         end
         }, this is not a place you would want to miss out on. \n\n Please read on for more information from other Dishers who have experienced working at #{business['properties']['name']} and see what they have to say.",
    category: if business['properties']['categories'].include?('catering.pub')
                'Pub'
              elsif business['properties']['categories'].include?('catering.bar')
                'Bar'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegan')
                'Cafe || Vegan Friendly'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegetarian')
                'Cafe || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.cafe')
                'Cafe'
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegan')
                "Restaurant || Vegan Friendly"
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegetarian')
                'Restaurant || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.restaurant')
                'Restaurant'
              end
  )
  images_url = 'https://source.unsplash.com/random/600x600/?bar,restaurant,cafe'
  image = URI.open(images_url)
  Business.all.last.photo.attach(io: image, filename: "#{Time.now.to_i}_unsplash_random.jpg", content_type: 'image/jpg')
  puts "Glesga business created"
end

puts "Creating Manchester businesses"
manc_businesses['features'].each do |business|
  Business.create!(
    name: business['properties']['name'],
    address: business['properties']['formatted'],
    email: business['properties']['datasource']['raw'].include?('email') ? business['properties']['datasource']['raw']['email'] : "#{business['properties']['name']}.outlook.com",
    phone_number: business['properties']['datasource']['raw'].include?('phone') ? business['properties']['datasource']['raw']['phone'] : "0161 532 #{rand{0..1000}}",
    size: "#{rand(0..25)} employees",
    business_hours: business['properties']['datasource']['raw']['opening_hours'],
    description: "#{business['properties']['name']} is a popular #{
      if business['properties']['categories'].include?('catering.pub')
      'Pub'
      elsif business['properties']['categories'].include?('catering.bar')
        'Bar'
      elsif business['properties']['categories'].include?('catering.restaurant')
        'Restaurant'
      elsif business['properties']['categories'].include?('catering.cafe')
        'Cafe'
      end
      } in the city of #{business['properties']['city']}. \n
      Located on #{business['properties']['datasource']['raw']['addr:street']}, #{business['properties']['name']} offers a wide range of #{
         if business['properties']['categories'].include?('catering.pub')
          'classic lagers and homely food'
         elsif business['properties']['categories'].include?('catering.bar')
           'smart cocktails and a smooth, relaxing atmosphere'
         elsif  business['properties']['categories'].include?('catering.restaurant')
           'fantasatic food in a relaxing environment'
         elsif business['properties']['categories'].include?('catering.cafe')
           'caffeinated treats and homecooked snacks'
         end
         }, this is not a place you would want to miss out on. \n
         Please read on on more information from other Dishers who have experienced working at #{business['properties']['name']} and see what they have to say.",
    category: if business['properties']['categories'].include?('catering.pub')
                'Pub'
              elsif business['properties']['categories'].include?('catering.bar')
                'Bar'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegan')
                'Cafe || Vegan Friendly'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegetarian')
                'Cafe || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.cafe')
                'Cafe'
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegan')
                "Restaurant || Vegan Friendly"
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegetarian')
                'Restaurant || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.restaurant')
                'Restaurant'
              end
  )
  images_url = 'https://source.unsplash.com/random/600x600/?bar,restaurant,cafe'
  image = URI.open(images_url)
  Business.all.last.photo.attach(io: image, filename: "#{Time.now.to_i}_unsplash_random.jpg", content_type: 'image/jpg')
  puts "Mancunian business created"
end

puts "Creating Coventry businesses"
cov_businesses['features'].each do |business|
  Business.create!(
    name: business['properties']['name'],
    address: business['properties']['formatted'],
    email: business['properties']['datasource']['raw'].include?('email') ? business['properties']['datasource']['raw']['email'] : "#{business['properties']['name']}.outlook.com",
    phone_number: business['properties']['datasource']['raw'].include?('phone') ? business['properties']['datasource']['raw']['phone'] : "0191 532 #{rand{0..100}}",
    size: "#{rand(0..25)} employees",
    business_hours: business['properties']['datasource']['raw']['opening_hours'],
    description: "#{business['properties']['name']} is a popular #{
      if business['properties']['categories'].include?('catering.pub')
      'Pub'
      elsif business['properties']['categories'].include?('catering.bar')
        'Bar'
      elsif business['properties']['categories'].include?('catering.restaurant')
        'Restaurant'
      elsif business['properties']['categories'].include?('catering.cafe')
        'Cafe'
      end
      } in the city of #{business['properties']['city']}. \n
      Located on #{business['properties']['datasource']['raw']['addr:street']}, #{business['properties']['name']} offers a wide range of #{
         if business['properties']['categories'].include?('catering.pub')
          'classic lagers and homely food'
         elsif business['properties']['categories'].include?('catering.bar')
           'smart cocktails and a smooth, relaxing atmosphere'
         elsif  business['properties']['categories'].include?('catering.restaurant')
           'fantasatic food in a relaxing environment'
         elsif business['properties']['categories'].include?('catering.cafe')
           'caffeinated treats and homecooked snacks'
         end
         }, this is not a place you would want to miss out on. \n
         Please read on on more information from other Dishers who have experienced working at #{business['properties']['name']} and see what they have to say.",
    category: if business['properties']['categories'].include?('catering.pub')
                'Pub'
              elsif business['properties']['categories'].include?('catering.bar')
                'Bar'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegan')
                'Cafe || Vegan Friendly'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegetarian')
                'Cafe || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.cafe')
                'Cafe'
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegan')
                "Restaurant || Vegan Friendly"
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegetarian')
                'Restaurant || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.restaurant')
                'Restaurant'
              end
  )
  images_url = 'https://source.unsplash.com/random/600x600/?bar,restaurant,cafe'
  image = URI.open(images_url)
  Business.all.last.photo.attach(io: image, filename: "#{Time.now.to_i}_unsplash_random.jpg", content_type: 'image/jpg')
  puts "Coventry business created"
end


puts "creating Birmingham businesses"

brum_businesses['features'].each do |business|
  Business.create!(
    name: business['properties']['name'],
    address: business['properties']['formatted'],
    email: business['properties']['datasource']['raw'].include?('email') ? business['properties']['datasource']['raw']['email'] : "#{business['properties']['name']}.outlook.com",
    phone_number: business['properties']['datasource']['raw'].include?('phone') ? business['properties']['datasource']['raw']['phone'] : "0121 532 #{rand{0..100}}",
    size: "#{rand(0..25)} employees",
    business_hours: business['properties']['datasource']['raw']['opening_hours'],
    description: "#{business['properties']['name']} is a popular #{
      if business['properties']['categories'].include?('catering.pub')
      'Pub'
      elsif business['properties']['categories'].include?('catering.bar')
        'Bar'
      elsif business['properties']['categories'].include?('catering.restaurant')
        'Restaurant'
      elsif business['properties']['categories'].include?('catering.cafe')
        'Cafe'
      end
      } in the city of #{business['properties']['city']}. \n
      Located on #{business['properties']['datasource']['raw']['addr:street']}, #{business['properties']['name']} offers a wide range of #{
         if business['properties']['categories'].include?('catering.pub')
          'classic lagers and homely food'
         elsif business['properties']['categories'].include?('catering.bar')
           'smart cocktails and a smooth, relaxing atmosphere'
         elsif  business['properties']['categories'].include?('catering.restaurant')
           'fantasatic food in a relaxing environment'
         elsif business['properties']['categories'].include?('catering.cafe')
           'caffeinated treats and homecooked snacks'
         end
         }, this is not a place you would want to miss out on. \n
         Please read on on more information from other Dishers who have experienced working at #{business['properties']['name']} and see what they have to say.",
    category: if business['properties']['categories'].include?('catering.pub')
                'Pub'
              elsif business['properties']['categories'].include?('catering.bar')
                'Bar'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegan')
                'Cafe || Vegan Friendly'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegetarian')
                'Cafe || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.cafe')
                'Cafe'
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegan')
                "Restaurant || Vegan Friendly"
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegetarian')
                'Restaurant || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.restaurant')
                'Restaurant'
              end
  )
  images_url = 'https://source.unsplash.com/random/600x600/?bar,restaurant,cafe'
  image = URI.open(images_url)
  Business.all.last.photo.attach(io: image, filename: "#{Time.now.to_i}_unsplash_random.jpg", content_type: 'image/jpg')
  puts "Birmingham business created"
end

puts "Creating Liverpool businesses"

lpool_businesses['features'].each do |business|
  Business.create!(
    name: business['properties']['name'],
    address: business['properties']['formatted'],
    email: business['properties']['datasource']['raw'].include?('email') ? business['properties']['datasource']['raw']['email'] : "#{Faker::Name.unique.name}.outlook.com",
    phone_number: business['properties']['datasource']['raw'].include?('phone') ? business['properties']['datasource']['raw']['phone'] : "0151 532 #{rand{0..100}}",
    size: "#{rand(0..25)} employees",
    business_hours: business['properties']['datasource']['raw']['opening_hours'],
    description: "#{business['properties']['name']} is a popular #{
      if business['properties']['categories'].include?('catering.pub')
      'Pub'
      elsif business['properties']['categories'].include?('catering.bar')
        'Bar'
      elsif business['properties']['categories'].include?('catering.restaurant')
        'Restaurant'
      elsif business['properties']['categories'].include?('catering.cafe')
        'Cafe'
      end
      } in the city of #{business['properties']['city']}. \n
      Located on #{business['properties']['datasource']['raw']['addr:street']}, #{business['properties']['name']} offers a wide range of #{
         if business['properties']['categories'].include?('catering.pub')
          'classic lagers and homely food'
         elsif business['properties']['categories'].include?('catering.bar')
           'smart cocktails and a smooth, relaxing atmosphere'
         elsif  business['properties']['categories'].include?('catering.restaurant')
           'fantasatic food in a relaxing environment'
         elsif business['properties']['categories'].include?('catering.cafe')
           'caffeinated treats and homecooked snacks'
         end
         }, this is not a place you would want to miss out on. \n
         Please read on on more information from other Dishers who have experienced working at #{business['properties']['name']} and see what they have to say.",
    category: if business['properties']['categories'].include?('catering.pub')
                'Pub'
              elsif business['properties']['categories'].include?('catering.bar')
                'Bar'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegan')
                'Cafe || Vegan Friendly'
              elsif business['properties']['categories'].include?('catering.cafe') && business['properties']['categories'].include?('vegetarian')
                'Cafe || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.cafe')
                'Cafe'
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegan')
                "Restaurant || Vegan Friendly"
              elsif business['properties']['categories'].include?('catering.restaurant') && business['properties']['categories'].include?('vegetarian')
                'Restaurant || Vegatarian Friendly'
              elsif business['properties']['categories'].include?('catering.restaurant')
                'Restaurant'
              end
  )
  images_url = 'https://source.unsplash.com/random/600x600/?bar,restaurant,cafe'
  image = URI.open(images_url)
  Business.all.last.photo.attach(io: image, filename: "#{Time.now.to_i}_unsplash_random.jpg", content_type: 'image/jpg')
  puts "Scouse business created"
end


puts "creating hardcoded businesses"

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
    name: "Milldreds Kings Cross",
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
    name: "Megano's Clapham Old Town",
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
    name: "Terryie's Cafe London",
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

  business_31 = Business.create!(
    name: "Temple Bar",
    address: "Klovenierburgswal 2, Amsterdam, 1012 CT",
    email: "info@temple-bar.com",
    phone_number: "+329 8784 9435",
    category: "Pub",
    size: "1-12 employees",
    business_hours: "9am - 2am",
    description: "Amsterdam's Finest Irish Bar."
  )

  business_31.photo.attach(io: File.open(Rails.root.join("app/assets/images/temple-bar.jpg")), filename: "temple-bar.jpg", content_type: 'image/jpg')

  business_32 = Business.create!(
    name: "The Swinging Arm",
    address: "63 Church Street, Birkenhead, CH41 5EG",
    email: "info@swingingarm.com",
    phone_number: "0151 878 9435",
    category: "Pub",
    size: "1-12 employees",
    business_hours: "9am - 12am",
    description: "Live Music and Real Ale served in the heart of the Birkenhead community."
  )

  business_32.photo.attach(io: File.open(Rails.root.join("app/assets/images/swinging-arm.jpg")), filename: "swinging-arm.jpg", content_type: 'image/jpg')


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
  puts "creating reviews"

  businesses = Business.all
  users = User.all


  user_content = ["I loved working at {business.name}! The hourly wage was competitive, and the management team treated us with respect and fairness. The customers were friendly, and the team culture was collaborative and supportive.",
    "Working at {business.name} was a great experience. The hourly wage was excellent, and the management team always listened to our concerns. The customers were diverse, and the team culture was vibrant and inclusive.",
    "{business.name} was a dream workplace. The hourly wage was generous, and the management team truly cared about our well-being. The customers were polite, and the team culture fostered a strong sense of unity and cooperation.",
    "I enjoyed my time at {business.name} due to the competitive hourly wage and the supportive management. The customers were understanding and appreciative, and the team culture was professional yet friendly.",
    "At {business.name}, the hourly wage exceeded my expectations, and the management team provided excellent guidance and support. The customers were a pleasure to serve, and the team culture promoted open communication and collaboration.",
    "Working at {business.name} was an absolute delight! The management team was exceptional, always supportive and encouraging. They made me feel valued and appreciated. The team culture was fantastic, and I made lifelong friends during my time there. The hourly wage was competitive, and I couldn't have asked for a better workplace.",
    "{business.name} had such a toxic work environment. The management team was disorganized and often unresponsive to employee concerns. It was frustrating to work there with such poor leadership. The customers were equally difficult, often rude and demanding. I wouldn't recommend this place to anyone.",
    "I can't say enough good things about the team at {business.name}. We had such a blast working together! The camaraderie was amazing, and I genuinely looked forward to going to work every day. We bonded over shared interests and created countless memories. The hourly wage was decent, but the friendships I made were priceless.",
    "{business.name} was a nightmare when it came to pay. The hourly wage was laughably low, barely enough to make ends meet. It was disheartening to work so hard and not be fairly compensated. The management team turned a blind eye to our concerns, making it even worse. Avoid this place if you value fair pay.",
    "Working at {business.name} was like being part of a big, dysfunctional family. The management team had no clue what they were doing. It was chaos and mismanagement at every turn. The customers weren't any better. They were rude, entitled, and often downright disrespectful. I wouldn't wish this workplace on my worst enemy.",
    "{business.name} had such an awesome team! We had a blast working together. We shared jokes, went out for team outings, and genuinely enjoyed each other's company. The management team fostered a fun and positive atmosphere. The hourly wage was fair, but the memories and friendships I made there were priceless.",
    "The pay at {business.name} was unbelievably good! I couldn't believe my luck. The hourly wage was way above industry standards, and it made a huge difference in my life. I felt valued and appreciated for my hard work. If you're looking for a place that pays well, this is it!",
    "{business.name} had some of the worst customers I've ever dealt with. They were entitled, rude, and disrespectful. It made the job incredibly difficult and draining. The management team didn't provide much support in handling difficult customers either. It was a constant battle.",
    "I can't say enough good things about the management at {business.name}. They were incredible! They provided guidance, support, and recognized our hard work. The team culture they fostered was one of respect and collaboration. It made all the difference in creating a positive work environment.",
    "I don't know how {business.name} managed to hire such terrible managers. They were out of touch, unapproachable, and had no clue how to motivate the team. It was a frustrating experience, and it reflected in the overall atmosphere of the workplace. It's a shame when bad management ruins a potentially great job.",
    "{business.name} was notorious for its terrible pay. It was insulting how little they offered for the amount of work we had to do. I constantly felt undervalued and underappreciated. It's a shame that they didn't see the importance of fair compensation.",
    "Dealing with difficult customers was a daily struggle at {business.name}. They were demanding, entitled, and treated the staff poorly. It made the job incredibly challenging and emotionally draining. It's a shame that some customers can ruin the experience for everyone.",
    "{business.name} had some of the most understanding and appreciative customers I've encountered. They were polite, patient, and made the job enjoyable. It made all the difference in creating a positive customer service experience. I miss interacting with those wonderful customers.",
    "Working at {business.name} had the added bonus of an amazing location. The store was situated in the heart of downtown, surrounded by vibrant shops and restaurants. During breaks, I would explore the area and discover new hidden gems. Plus, the staff discount was a fantastic perk that allowed me to enjoy the local offerings even more!",
    "{business.name} knew how to spoil its employees with incredible perks. Not only did we receive a competitive hourly wage, but we also enjoyed exclusive staff discounts at partner establishments. It was fantastic to be able to experience local attractions, dining, and entertainment at a discounted price. I truly felt valued and appreciated.",
    "Working at {business.name} offered excellent pay, which was a major plus. However, the management had extremely high standards and often placed unrealistic demands on the team. It made for a stressful work environment where work-life balance was a constant struggle. Additionally, the poor transport links made the daily commute challenging, especially during late shifts.",
    "The pay at {business.name} was above average, and that was a definite highlight. However, the management had extremely strict standards and often exhibited micromanagement tendencies. This created a stressful work environment where every move was monitored closely. Moreover, the lack of convenient transport links meant that commuting after late shifts was a constant struggle.",
    "At {business.name}, the pay was one of the best aspects of the job. However, the management had exceedingly high expectations, which could be overwhelming at times. Their strict standards sometimes made it challenging to meet their demands. Additionally, the location had poor transport links, making the commute inconvenient and time-consuming.",
    "{business.name} paid its employees well, which was a definite advantage. The team environment was also fantastic, with friendly colleagues who made work enjoyable. However, the customers could be incredibly difficult and demanding. Dealing with their constant complaints and entitled attitudes made it challenging to maintain a positive experience."
  ]

  10.times do
    user = users.sample

    positive_title = ["Great Work Environment", "Excellent Team", "Flexible schedule - great for casual work", "Good money", "Free lunches and good management"]
    negative_title = ["I hated every second there", "Don't work there", "They never pay on time", "They don't pay fair", "Terrible management"]

    businesses.each do |business|

      content = user_content.sample.gsub('{business.name}', "#{business.name}")
      title = content.include?("toxic") || content.include?("nightmare") || content.include?("rude") || content.include?("bad") || content.include?("shame") || content.include?("strict") ? negative_title.sample : positive_title.sample
      rating = negative_title.include?(title) ? rand(1..3) : rand(4..5)
      recommended = rating < 4 ? false : true

      Review.create!(
        business: business,
        user: user,
        content: content,
        title: title,
        job_title: ["Manager", "Bartender", "Waiter", "Chef", "Bar-back", "Supervisor", "Kitchen Porter", "Head Bartender", "Floor staff", "Head Chef"].sample,
        rating: rating,
        recommended: recommended,
        wage: rand(7.0..14.5),
        votes: rand(0..10),
      )
      puts "review created"
    end
  end
