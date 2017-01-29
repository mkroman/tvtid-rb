module TVTid
  class Schedule
    # @return [Channel] the channel the schedule belongs to.
    attr_reader :channel
    # @return [Array<Program>] the list of programs in the schedule.
    attr_reader :programs

    # Constructs a new schedule for a channel.
    #
    # @param channel [Channel] the parent channel
    # @param programs [Array<Program>] a list of programs
    def initialize channel, programs = []
      @channel = channel
      @programs = programs
    end

    # Returns the previous, current and upcoming programs at a given `time`.
    #
    # @return [(Array<Program>, Program, Array<Program>)] the previous, the
    #   current and the upcoming programs relative to the given `time`.
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

    # @return [(Array<Program>, Program, Array<Program>)] the previous, the
    #   current and the upcoming programs relative to the current time.
    def current
      self.at DateTime.now
    end
  end
end
