# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# hotel = Hotel.create({id: 'abcd', destination_id: 1234, name: "Beach Villas Singapore",
#  description: "Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking."})
# # hotel = Hotel.where(id: 'abcd').first
# Location.create({hotel_id: 'abcd', lat: 1.264751, lng: 103.824006,
#  address: "8 Sentosa Gateway, Beach Villas, 098269", city: "Singapore", country: "Singapore"})
# Image.create({hotel_id: 'abcd', category: "rooms",
#   link: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", description: "Double room"})

Hotel.create({id: 'efgh', destination_id: 1234, name: 'InterContinental Singapore Robertson Quay',
description: "Enjoy sophisticated waterfront living at the new InterContinental® Singapore Robertson Quay, luxury's preferred address nestled in the heart of Robertson Quay along the Singapore River, with the CBD just five minutes drive away. Magnifying the comforts of home, each of our 225 studios and suites features a host of thoughtful amenities that combine modernity with elegance, whilst maintaining functional practicality. The hotel also features a chic, luxurious Club InterContinental Lounge."})
