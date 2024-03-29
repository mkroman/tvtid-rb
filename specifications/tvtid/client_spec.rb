require_relative '../spec_helper'

describe TVTid::Client, :vcr do
  describe '#channels' do
    it 'should return a list of channels' do
      expect(subject.channels.first).to be_kind_of TVTid::Channel
    end

    it 'should not be empty' do
      expect(subject.channels).to_not be_empty
    end
  end

  describe '#schedules_for' do
    it 'should return nil when date param is not a date' do
      expect(subject.schedules_for(100)).to be_nil
    end

    it 'should return a schedule' do
      expect(subject.schedules_for(Date.today).first).to be_kind_of TVTid::Schedule
    end

    context 'with channel list' do
      it 'should only return list for select channels' do
        select_channels = [1, 2, 3]
        channels = subject.channels.select{|channel| select_channels.include? channel.id }
        schedules = subject.schedules_for Date.today, channels

        schedules.each do |schedule|
          expect(select_channels).to include schedule.channel.id
        end
      end
    end
  end

  describe '#schedules_for_today' do
    it 'should return a non-empty array' do
      schedules = subject.schedules_for_today
      expect(schedules).to be_kind_of Array
      expect(schedules).to_not be_empty
    end
  end

  describe '#channel_schedule' do
    it 'should return a schedule' do
      channel = subject.channels.first
      expect(subject.channel_schedule(channel)).to be_kind_of TVTid::Schedule
    end
  end

  describe '#get_program_details!' do
    it 'should update the details of the program' do
      schedule = subject.channel_schedule(subject.channels.first)
      program = schedule.programs.first

      # The program shouldn't have a description yet.
      expect(program.description).to be_nil

      subject.get_program_details! program
      expect(program.description).to_not be_empty
    end

    it 'should return the program' do
      program = double(id: 1, channel_id: 1).as_null_object
      
      expect(subject.get_program_details!(program)).to eq program
    end
  end
end
