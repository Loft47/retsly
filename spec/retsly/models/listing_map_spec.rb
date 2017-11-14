require_relative '../../spec_helper'

RSpec.describe Retsly::Models::ListingMap do
  subject { Retsly::Models::ListingMap }

  describe '#initialize' do
    it 'should have attributes' do
      expect(subject.new.attributes).to include(
        :id,
        :coordinates,
        :url
      )
    end
  end
end
