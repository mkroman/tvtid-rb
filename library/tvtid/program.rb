module TVTid
  class Program
    # The id of the program.
    attr_reader :id
    # The title of the program.
    attr_reader :title
    # The time the program starts at.
    attr_accessor :start_time
    # The time the program stops at.
    attr_accessor :stop_time
    # A url where the user can see more information about the program.
    attr_accessor :url
    # The ID of the channel.
    attr_accessor :channel_id
    # The category of the program.
    attr_accessor :category
    # The description of the program.
    attr_accessor :description
    # The original non-localized title of the program.
    attr_accessor :original_title
    # The year of production of the program.
    attr_accessor :production_year
    # The production country of the program.
    attr_accessor :production_country
    # Teaser text for the program.
    attr_accessor :teaser
    # Unique series id if the program is a series.
    attr_accessor :series_id
    # Episode and season information if the program is a series.
    attr_accessor :series_info

    # Constructs a new `Program` with an `id` and a `title`.
    def initialize id, title
      @id = id
      @title = title
    end

    # Updates the program information from a json object.
    def parse_json! json
      @start_time = Time.at(json['start']).to_datetime
      @stop_time = Time.at(json['stop']).to_datetime
      @url = json['url'] if json.key?('url')
      @channel_id = json['channelId'] if json.key?('channelId')
      @category = json['category'] if json.key?('category')
      @description = json['desc'] if json.key?('desc')
      @production_year = json['prodYear'] if json.key?('prodYear')
      @production_country = json['prodCountry'] if json.key?('prodCountry')
      @teaser = json['teaser'] if json.key?('teaser')
      @series_id = json['series_id'] if json.key?('seriesId')
      @series_info = json['series'] if json.key?('series')
    end

    # Constructs a `Program` from a json object.
    #
    # @returns Program if json object has an `id` and a `title` - nil otherwise.
    def self.from_json json
      return nil unless json['id'] and json['title']

      Program.new(json['id'], json['title']).tap do |program|
        program.parse_json! json
      end
    end
  end
end
