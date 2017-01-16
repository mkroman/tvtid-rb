# encoding: utf-8

module TVTid
  # A category for an EPG entry.
  class Category
    attr_accessor :color, :shade
    attr_reader :name

    # Constructs a new category with a name.
    def initialize name
      @name = name
    end

    # Creates a new category from a json object.
    #
    # @returns a category.
    def self.from_json json
      return nil unless json['name']

      Category.new(json['name']).tap do |category|
        category.color = json['color']
        category.shade = json['shade']
      end
    end
  end
end
