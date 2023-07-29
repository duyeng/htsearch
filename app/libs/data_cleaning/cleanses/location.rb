module DataCleaning
  module Cleanses
    class Location < Base
      cleanse :lat, cleaner: []
      cleanse :lng, cleaner: []
      cleanse :address, cleaner: [:strip]
      cleanse :city, cleaner: [:strip]
      cleanse :country, cleaner: [:strip]
    end
  end
end