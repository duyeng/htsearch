module DataExtract
  class Factory
    def self.get_supplier(name)
      case name.to_sym
      when :acme
        DataExtract::Acme.new
      when :paperflies
        DataExtract::Paperflies.new
      when :patagonia
        DataExtract::Patagonia.new
      end
    end
  end
end