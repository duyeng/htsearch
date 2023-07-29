module DataCleaning
  class Factory
    def self.get(name)
      case name.to_sym
      when :hotels
        DataCleaning::Cleanses::Hotel.new
      when :locations
        DataCleaning::Cleanses::Location.new
      when :images
        DataCleaning::Cleanses::Image.new
      when :amenities
        DataCleaning::Cleanses::Amenity.new
      end
    end
  end
end