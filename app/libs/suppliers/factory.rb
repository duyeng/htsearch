module Suppliers
  class Factory
    def self.get(name)
      case name.to_sym
      when :acme
        Suppliers::Acme.new
      when :paperflies
        Suppliers::Paperflies.new
      when :patagonia
        Suppliers::Patagonia.new
      end
    end
  end
end