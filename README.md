# TVTid
This is a Ruby library for interfacing with the unofficial API on `tvtid.tv2.dk`.

[![Build Status](https://travis-ci.org/mkroman/tvtid.svg)](https://travis-ci.org/mkroman/tvtid)
[![Dependency Status](https://gemnasium.com/mkroman/tvtid.svg)](https://gemnasium.com/mkroman/tvtid)

## Example
```ruby
require 'tvtid'

client = TVTid::Client.new
schedules = client.schedules_for_today
channel_length = client.channels.map(&:title).map(&:length).max

schedules.each do |schedule|
  channel = schedule.channel
  already_aired_programs, currently_running_program, upcoming_programs = schedule.current
  
  if program = currently_running_program
    print "#{channel.title.ljust channel_length} [#{program.start_time.strftime('%R')}] #{program.title} "
    
    upcoming_programs[0...2].each do |program|
      print "[#{program.start_time.strftime('%R')}] #{program.title} "
    end
    
    puts
  end
end

# TV 2          [20:00] Fuld plade [21:15] Baby Surprise [23:05] Obsessed 
# DR1           [20:00] X Factor [21:00] TV AVISEN [21:15] Vores vejr 
# TV 2 Charlie  [20:30] Fede Finn i modvind [21:25] Fede Finn i modvind [22:15] En sag for Frost 
# DR2           [20:45] VM håndbold: Kroatien-Norge, direkte [21:20] VM håndbold: Studiet [21:35] VM håndbold: Kroatien-Norge, direkte 
# TV3           [20:00] Dagens mand [21:00] American Pie 2 [23:10] The Joneses
# …
```

## License
`tvtid` is published under the MIT license which can be read in the `LICENSE` file.
