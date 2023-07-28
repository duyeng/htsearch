class Hotel < ApplicationRecord
  include ActiveModel::Serialization

  has_one :location, class_name: 'Location', foreign_key: 'hotel_id'
  has_many :images, class_name: 'Image', foreign_key: 'hotel_id'
  has_many :amenities, class_name: 'Amenity', foreign_key: 'hotel_id'
end
