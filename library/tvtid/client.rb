# encoding: utf-8

module TVTid
  class Client
    # The cache time to live.
    CACHE_TTL = 1 * 60 * 60 * 24 # 1 day
    # The soft cache time to live.
    CACHE_SOFT_TTL = 7 * 60 * 60 * 24 # 7 days
    # The API backend host.
    API_BASE_URI = URI 'http://tvtid-app-backend.tv2.dk'

    # The default HTTP request headers
    HTTP_REQUEST_HEADERS = {
      'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36'
    }

    # The default channels to return in a days schedule
    DEFAULT_CHANNELS = [1, 3, 5, 2, 31, 133, 7, 6, 4, 10155, 10154, 10153, 8,
                        77,   156,  10093,  10066,  14, 10089, 12566, 10111, 70,
                        118, 153, 94, 12948, 145, 185, 157, 15, 71, 93, 15049,
                        219, 37, 248, 186]

    # Constructs a new client
    def initialize
      @cache = LRUCache.new ttl: CACHE_TTL, soft_ttl: CACHE_SOFT_TTL
      @http = Net::HTTP.new API_BASE_URI.host, API_BASE_URI.port
    end

    # Returns a schedule for the given date
    #
    # @param date A date
    # @param channels A list of channel ids to request schedules for
    def schedules_for date, channels = []
      return nil unless date.is_a? Date

      channels = self.channels.select{|c| DEFAULT_CHANNELS.include? c.id } if channels.empty?
      formatted_date = date.iso8601
      cache_key = "schedule-#{formatted_date}-#{channels.map(&:id).join ','}"

      @cache.fetch cache_key do
        channel_queries = channels.map{|c| "ch=#{c.id}" }.join '&'
        response = @http.get "/api/tvtid/v1/dayviews/#{formatted_date}?#{channel_queries}", HTTP_REQUEST_HEADERS
        json_data = MultiJson.load response.body

        json_data.map do |schedule|
          channel = channels.find{|channel| channel.id == schedule['id']}
          programs = schedule['programs'].map{|program| Program.from_json program }
          programs.sort!{|a, b| a.start_time <=> b.start_time }

          Schedule.new channel, programs
        end
      end
    end

    # Returns a list of schedules for today
    #
    # This is the same as using `schedules_for Date.today`
    def schedules_for_today channels = []
      schedules_for Date.today, channels
    end

    # Returns a days schedule for a given channel and date
    #
    # @param channel [Channel] The channel to get the schedule for
    # @param date [Date] The date of the schedule
    def channel_schedule channel, date = Date.today
      schedules_for(date, [channel]).first
    end

    # Returns a list of channels
    def channels
      @cache.fetch 'channels' do
        response = @http.get '/api/tvtid/v1/channels', HTTP_REQUEST_HEADERS

        json_data = MultiJson.load response.body
        json_data.map{|json_channel_data| Channel.from_json json_channel_data }
      end
    end
  end
end
