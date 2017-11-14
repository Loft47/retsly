require_relative '../spec_helper'

RSpec.describe Retsly::ListingMap do
  let(:client) { Retsly::Client.new(access_token: access_token, vendor: vendor) }
  let(:access_token) { 'dog' }
  let(:vendor) { 'test' }

  subject { Retsly::ListingMap.new(client: client) }

  describe '#initialize' do
    it 'should accept a client' do
      expect(subject.client).to eq client
    end

    context 'no vendor' do
      let(:vendor) { nil }
      it 'should raise an error when there is no vendor' do
        expect { subject }.to raise_error RuntimeError
      end
    end
  end

  describe '#all' do
    it 'should return a collection of listing' do
      retsly_mock(path: 'listings/maps', vendor_id: vendor)
      expect(subject.all).to all(be_a(Retsly::Models::ListingMap))
    end
  end
end
