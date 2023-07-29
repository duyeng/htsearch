module DataCleaning
  module Cleanses
    class Image < Base
      cleanse :url, cleaner: []
      cleanse :description, cleaner: [:strip, :downcase]
      cleanse :category, cleaner: [:strip, :downcase]
    end
  end
end