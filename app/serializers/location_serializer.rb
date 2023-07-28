class LocationSerializer < ActiveModel::Serializer
  attributes :lat, :lng, :address, :city, :country, :postal_code
end
