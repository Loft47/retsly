module Retsly
  class ListingMap
    attr_accessor :client

    def initialize(client:)
      @client = client
      raise 'Must Supply Vendor' unless @client.vendor
    end

    def all
      find_all(path: "#{@client.vendor}/listings/maps")
    end

    private

    def find_all(path:)
      @client.get(path).map do |vendor_attributes|
        Retsly::Models::ListingMap.new(
          vendor_attributes.merge(client: @client)
        )
      end
    end
  end
end
