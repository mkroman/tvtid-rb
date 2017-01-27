require_relative '../spec_helper'

describe TVTid::Program do
  describe '.from_json' do
    let(:channel_listings) { load_json_fixture 'channel-listings.json' }

    context 'when theres no id and title' do
      let(:json_data) { %%{"stop":1484712300,"start":1484709900}% }
      let(:json) { Oj.load json_data }

      it 'should return nil' do
        expect(described_class.from_json(json)).to be_nil
      end
    end

    context 'channel listing' do
      let(:channel_listing) { channel_listings.first }

      subject do
        described_class.from_json channel_listing['programs'].first
      end

      it 'should have a title' do
        expect(subject.title).to_not be_empty
      end

      it 'should have a start time' do
        expect(subject.start_time).to be_kind_of DateTime
        expect(subject.start_time.year).to eq 2017
      end

      it 'should have a stop time' do
        expect(subject.stop_time).to be_kind_of DateTime
        expect(subject.start_time.year).to eq 2017
      end
    end

    context 'program details' do
      let(:program_details) { load_json_fixture 'program-details.json' }
      subject { described_class.from_json program_details }

      it 'should have a title' do
        expect(subject.title).to_not be_empty
      end

      it 'should have a start time' do
        expect(subject.start_time).to be_kind_of DateTime
        expect(subject.start_time.year).to eq 2017
      end

      it 'should have a stop time' do
        expect(subject.stop_time).to be_kind_of DateTime
        expect(subject.start_time.year).to eq 2017
      end

      its(:id) { is_expected.to be_a Numeric }
      its(:url) { is_expected.to_not be_nil }
      its(:channel_id) { is_expected.to be_a Numeric }
      its(:category) { is_expected.to_not be_nil }
      its(:description) { is_expected.to_not be_nil }
      its(:production_year) { is_expected.to be_kind_of Numeric }
      its(:production_country) { is_expected.to_not be_nil }
      its(:teaser) { is_expected.to_not be_nil }
    end
  end
end
