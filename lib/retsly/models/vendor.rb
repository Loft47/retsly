module Retsly
  module Models
    class Vendor
      extend ::ModelAttribute
      attr_accessor :client
      attribute :vendor_id, :string
      attribute :name, :string
      attribute :logo, :string
      attribute :test, :boolean
      attribute :type, :string
      attribute :update, :string
      attribute :center, :json
      attribute :boundary, :json
      attribute :active_agents, :integer
      attribute :active_listings, :integer
      attribute :active_offices, :integer

      def initialize(attributes = {})
        set_attributes(attributes)
      end
    end
  end
end
