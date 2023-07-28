module DataCleaning
  module Cleanses
    class HotelCleanse < BaseCleanse
      cleanse :name, cleaner: [:strip]
      cleanse :description, cleaner: [:strip]
    end
  end
end