require_relative '../spec_helper'

describe TVTid::Schedule do
  describe '#at' do
    it 'should return an array, a program and another array' do
      client = TVTid::Client.new
      schedule = client.channel_schedule client.channels.first

      now = DateTime.now
      time = DateTime.new now.year, now.month, now.day, 12, 00
      previous, current, upcoming = schedule.at time

      expect(previous).to be_a Array
      expect(current).to be_a TVTid::Program
      expect(upcoming).to be_a Array
    end
  end

  describe '#current' do
    it 'should call #at' do
      client = TVTid::Client.new
      schedule = client.channel_schedule client.channels.first

      expect(schedule).to receive :at
      schedule.current
    end
  end
end
