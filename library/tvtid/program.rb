module TVTid
  class Program
    # @return [Numeric] the id of the program.
    attr_reader :id
    # @return [String] the title of the program.
    attr_reader :title
    # @return [DateTime] the time the program starts at.
    attr_accessor :start_time
    # @return [DateTime] the time the program ends at.
    attr_accessor :stop_time
    # @return [String] a URL to where the user can see more information about
    #   the program.
    attr_accessor :url
    # @return [Numeric] the ID of the channel.
    attr_accessor :channel_id
    # @return [String] the category of the program.
    attr_accessor :category
    # @return [String] the description of the program.
    attr_accessor :description
    # @return [String] the original non-localized title of the program.
    attr_accessor :original_title
    # @return [Numeric] the year of production of the program.
    attr_accessor :production_year
    # @return [String] the production country of the program.
    attr_accessor :production_country
    # @return [String] the teaser text of the program.
    attr_accessor :teaser
    # @return [Numeric] a unique series id if the program is a series.
    attr_accessor :series_id
    # @return [Hash, nil] episode and season information if the program is a
    #   series.
    attr_accessor :series_info

    # Constructs a new `Program` with an `id` and a `title`.
    def initialize id, title
      @id = id
      @title = title
    end

    # Updates the program information from a json object.
    #
    # @param json [Hash] Parsed JSON object
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
    # @param json [Hash] Parsed JSON object
    # @return [Program, nil] program if the given `json` object has an `id` 
    #   and a `title` attribute, nil otherwise.
    def self.from_json json
      return nil unless json['id'] and json['title']

      Program.new(json['id'], json['title']).tap do |program|
        program.parse_json! json
      end
    end
  end
end
