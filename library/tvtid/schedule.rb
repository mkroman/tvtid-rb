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
  end
end
