# encoding: utf-8

module TVTid
  class Channel
    attr_accessor :icon, :logo, :logo_svg, :category, :region, :language
    attr_reader :id, :title

    # Constructs a new channel with an id and a title.
    def initialize id, title
      @id = id
      @title = title
    end

    # Creates a new channel from a json object.
    # 
    # @returns a channel.
    def self.from_json json
      return nil unless json['id'] and json['title']

      Channel.new(json['id'], json['title']).tap do |channel|
        channel.icon = json['icon']
        channel.logo = json['logo']
        channel.logo_svg = json['svgLogo']
        channel.category = json['category']
        channel.region = json['region']
        channel.language = json['lang']
      end
    end
  end
end
