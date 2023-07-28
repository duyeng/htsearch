class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :description, :location, :images, :amenities

  def location
    if object.location
      LocationSerializer.new(object.location)
    end
  end

  def images
    images_hash = {}
    object.images.each do |image|
      images_hash[image.category] ||= []
      images_hash[image.category] << ImageSerializer.new(image)
    end
    images_hash
  end

  def amenities
    amenities_hash = {}
    object.amenities.each do |amenity|
      amenities_hash[amenity.category] ||= []
      amenities_hash[amenity.category] << amenity.name
    end
    amenities_hash
  end
end
