module Importer
  class Factory
    def self.get(name)
      case name.to_sym
      when :hotels
        Importer::Hotels.new
      when :locations
        Importer::Locations.new
      when :images
        Importer::Images.new
      when :amenities
        Importer::Amenities.new
      end
    end
  end
end