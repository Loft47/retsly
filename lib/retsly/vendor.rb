module Retsly
  class Vendor
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      find_all(path: 'vendors')
    end

    def find(id)
      vendor_attributes = @client.get("vendors/#{id}")
      Retsly::Models::Vendor.new(
        vendor_attributes.merge(client: @client)
      )
    end

    def approved
      find_all(path: 'vendors/approved')
    end

    private

    def find_all(path:)
      @client.get(path).map do |vendor_attributes|
        Retsly::Models::Vendor.new(
          vendor_attributes.merge(client: @client)
        )
      end
    end
  end
end
