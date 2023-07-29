module DataImport
  class Factory
    def self.get(name)
      case name.to_sym
      when :hotels
        DataImport::Hotels.new
      when :locations
        DataImport::Locations.new
      when :images
        DataImport::Images.new
      when :amenities
        DataImport::Amenities.new
      end
    end
  end
end