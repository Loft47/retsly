module Retsly
  module Models
    class ListingMap
      extend ModelAttribute
      attr_accessor :client
      attribute :id,          :string
      attribute :coordinates, :json
      attribute :url,         :string

      def initialize(attributes = {})
        set_attributes(attributes)
      end
    end
  end
end
