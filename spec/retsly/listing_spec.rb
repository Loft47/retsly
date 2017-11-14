require_relative '../spec_helper'

RSpec.describe Retsly::Listing do
  let(:client) { Retsly::Client.new(access_token: access_token, vendor: vendor) }
  let(:access_token) { 'dog' }
  let(:vendor) { 'test' }
  let(:where_params) { { mls_listing_id: { eq: '12345' }, state: { eq: 'CA' } } }

  subject { Retsly::Listing.new(client: client) }

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
      retsly_mock(path: 'listings', vendor_id: vendor)
      listings = subject.all
      expect(listings).to all(be_a(Retsly::Models::Listing))
    end
  end

  describe '#find' do
    let(:listing_id) { '3fcc5' }
    it 'should find a specific listing' do
      retsly_mock(path: "listings/#{listing_id}", vendor_id: vendor)
      listings = subject.find(listing_id)
      expect(listings).to be_a(Retsly::Models::Listing)
    end
  end

  describe '#Map' do
    it 'should return a collection of listing coordinates' do
      expect(subject.Map).to be_a(Retsly::Models::ListingMap)
    end
  end

  describe '#where' do
    context 'Good params' do
      it 'should set query parameters' do
        subject.where(where_params)
        expect(subject.where_params).to include(
          mls_listing_id: { eq: '12345' }, state: { eq: 'CA' }
        )
      end

      it 'should append query' do
        subject.where(where_params).where(country: { eq: 'USA' })
        expect(subject.where_params).to include(
          mls_listing_id: { eq: '12345' }, state: { eq: 'CA' }, country: { eq: 'USA' }
        )
      end
    end

    context 'bad parameter key' do
      let(:where_params) { { foo: { eq: 1 } } }
      it 'should raise an error' do
        expect { subject.where(where_params) }.to raise_error(RuntimeError, 'Invalid Field')
      end
    end

    context 'bad operator' do
      let(:where_params) do
        { country: { policatl: 'Democratic' } }
      end
      it 'should raise an error' do
        expect { subject.where(where_params) }.to raise_error(RuntimeError, 'Invalid Operator')
      end
    end
  end

  describe 'Searching for mls_listing_id' do
    it 'should a single listing' do
      subject.where(where_params)
      retsly_mock_where(path: 'listings', vendor_id: vendor, query_string: subject.where_query)
      expect(subject.all.first.mls_listing_id).to eq '12345'
      expect(subject.all.count).to eq 1
    end
  end

  describe '#where_query' do
    it 'should return blank for blank query' do
      expect(subject.where_query). to eq ''
    end

    it 'should format where as a query' do
      expect(subject.where(where_params).where_query). to eq '&mlsListingID.eq=12345&state.eq=CA'
    end
  end
end
