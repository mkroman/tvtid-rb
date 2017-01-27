module TVTid
  class Schedule
    # The channel the schedule belongs to.
    attr_reader :channel
    # The list of programs in the schedule.
    attr_reader :programs

    # Constructs a new schedule for a `channel`.
    def initialize channel, programs = []
      @channel = channel
      @programs = programs
    end

    # Get the previous, current and upcoming programs at a given `time`.
    #
    # @returns [previous<Array>, current<Program>, upcoming<Array>]
    def at time
      cur_idx = 0

      @programs.each_with_index do |program, index|
        if program.start_time <= time and program.stop_time >= time
          cur_idx = index
          break
        end
      end

      if cur_idx != 0
        return @programs[0..cur_idx-1], @programs[cur_idx], @programs[cur_idx+1..-1]
      end
    end

    # Returns the previous, current and upcoming programs.
    #
    # @see at
    def current
      self.at DateTime.now
    end
  end
end
