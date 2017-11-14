require_relative '../spec_helper'

RSpec.describe Retsly::Vendor do
  let(:client) { Retsly::Client.new(access_token: access_token) }
  let(:access_token) { 'dog' }

  subject { Retsly::Vendor.new(client: client) }

  describe '#initialize' do
    it 'should accept a client' do
      expect(subject.client).to eq client
    end
  end

  describe '#all' do
    it 'should return a collection of vendors' do
      retsly_mock(prefix: 'vendors')
      vendors = subject.all
      expect(vendors).to all(be_a(Retsly::Models::Vendor))
    end
  end

  describe '#find' do
    it 'should find a specific vendor' do
      retsly_mock(prefix: 'vendors', vendor_id: 'test')
      vendor = subject.find('test')
      expect(vendor).to be_a(Retsly::Models::Vendor)
      expect(vendor.name).to eq 'Static Test Vendor'
    end
  end

  describe '#approved' do
    it 'should return a collection of vendors' do
      retsly_mock(prefix: 'vendors/approved')
      vendors = subject.approved
      expect(vendors).to all(be_a(Retsly::Models::Vendor))
    end
  end
end
