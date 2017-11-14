require_relative '../../spec_helper'

RSpec.describe Retsly::Models::Vendor do
  subject { Retsly::Models::Vendor }

  describe '#initialize' do
    it 'should have attributes' do
      expect(subject.new.attributes).to include(
        :vendor_id,
        :name,
        :logo,
        :test,
        :type,
        :update,
        :center,
        :boundary,
        :active_agents,
        :active_listings,
        :active_offices
      )
    end
  end
end
