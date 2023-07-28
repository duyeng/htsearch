module DataCleaning
  module Cleanses
    class LocationCleanse < BaseCleanse
      cleanse :lat, cleaner: [:string_to_float]
      cleanse :lng, cleaner: [:string_to_float]
      cleanse :address, cleaner: [:strip]
      cleanse :city, cleaner: [:strip]
      cleanse :country, cleaner: [:strip]
    end
  end
end