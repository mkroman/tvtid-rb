require_relative '../spec_helper'

describe TVTid::Category do
  describe 'initialize' do
    subject { described_class.new 'some_name' }

    it 'should set a name' do
      expect(subject.name).to eq 'some_name'
    end
  end

  describe '.from_json' do
    let(:json_data) { '{"name":"Film","color":"e23e97","shade":"af3574"}' }

    subject { TVTid::Category.from_json Oj.load(json_data) }

    it 'should return nil when json object has no name' do
      category = TVTid::Category.from_json '{"color"e23e97","shade":"af3574"}'

      expect(category).to be_nil
    end

    it 'should have color' do
      expect(subject.color).to eq 'e23e97'
    end

    it 'should have shade' do
      expect(subject.shade).to eq 'af3574'
    end
  end
end
