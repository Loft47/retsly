require_relative '../spec_helper'

RSpec.describe Retsly::Client do
  let(:access_token) { 'dog' }
  let(:vendor) { 'test' }
  let(:status) { true }
  let(:url) { 'https://rets.io/api/v1/' }
  let(:raw_response) do
    File.read(SPEC_PATH + '/spec/fixtures/vendors.json')
  end

  subject { Retsly::Client.new(access_token: access_token, vendor: vendor) }

  describe '#initialize' do
    it 'should take an access_token' do
      expect(subject).to be_a Retsly::Client
      expect(subject.access_token).to eq access_token
      expect(subject.vendor).to eq vendor
    end

    context 'No access_token' do
      let(:access_token) { nil }
      it 'should raise an error' do
        expect { subject }.to raise_error RuntimeError
      end
    end
  end

  describe '#get' do
    it 'should call a webpage' do
      get
      subject.get('vendor')
    end

    context 'without a page' do
      it 'should raise an error' do
        expect { subject.get(nil) }.to raise_error RuntimeError
      end
    end

    context 'unsuccessful' do
      let(:raw_response) do
        File.read(SPEC_PATH + '/spec/fixtures/vendors_failure.json')
      end

      it 'should raise an error' do
        get
        expect { subject.get('vendor') }.to raise_error(
          RuntimeError,
          'API Error: 400 :: QueryNotAllowed-id is not a valid key for vendor'
        )
      end
    end
  end

  describe '#raw' do
    it 'should accept query params' do
      expect(Net::HTTP).to receive(:get).with(URI.parse("#{url}test?access_token=#{access_token}&foo.eq=1"))
      subject.raw(vendor, '&foo.eq=1')
    end
  end

  describe 'API Endpoints' do
    it { expect(subject.Vendor).to be_a Retsly::Vendor }
    it { expect(subject.Listing).to be_a Retsly::Listing }
  end

  def get
    expect(Net::HTTP).to receive(:get).with(
      URI.parse("#{url}vendor?access_token=#{access_token}")
    ).and_return(raw_response)
  end
end
