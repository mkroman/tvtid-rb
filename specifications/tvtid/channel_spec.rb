require_relative '../spec_helper'

describe TVTid::Channel do
  subject { described_class.new 1, 'Channel name' }

  it 'should have an id and a title' do
    expect(subject.id).to eq 1
    expect(subject.title).to eq 'Channel name'
  end

  describe '.from_json' do
    context 'when the json object has an id and a title' do
      let(:json_data) { '{"id":3,"title":"TV 2","icon":"http://epg-images.tv2.dk/channellogos/icon/3.png","logo":"http://epg-images.tv2.dk/channellogos/logo/3.png","svgLogo":"http://epg-images.tv2.dk/channellogos/svg/3.svg","category":"danske","region":"dk","lang":"dk"}' }

      subject { TVTid::Channel.from_json Oj.load(json_data) }

      it 'should return a channel' do
        expect(subject).to be_kind_of described_class
      end
    end

    context "when the json object doesn't have an id" do
      let(:json_data) { '{"title":"TV 2","icon":"http://epg-images.tv2.dk/channellogos/icon/3.png","logo":"http://epg-images.tv2.dk/channellogos/logo/3.png","svgLogo":"http://epg-images.tv2.dk/channellogos/svg/3.svg","category":"danske","region":"dk","lang":"dk"}' }

      subject { TVTid::Channel.from_json Oj.load(json_data) }

      it 'should return nil' do
        expect(subject).to be_nil
      end
    end

    let(:json_data) { '{"id":1,"title":"TV 2","icon":"http://epg-images.tv2.dk/channellogos/icon/3.png","logo":"http://epg-images.tv2.dk/channellogos/logo/3.png","svgLogo":"http://epg-images.tv2.dk/channellogos/svg/3.svg","category":"danske","region":"dk","lang":"dk"}' }
    subject { TVTid::Channel.from_json Oj.load(json_data) }

    it "should map 'svgLogo' to #logo_svg" do
      expect(subject.logo_svg).to eq 'http://epg-images.tv2.dk/channellogos/svg/3.svg'
    end

    it "should map 'lang' to #language" do
      expect(subject.language).to eq 'dk'
    end
  end
end
