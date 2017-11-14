module Retsly
  # rubocop:disable Style/MethodName
  class Listing
    attr_accessor :client
    attr_accessor :where_params
    OPERATORS = %i[eq ne gt lt gte lte in].freeze

    def initialize(client:)
      @client = client
      @where_params = ::Hashie::Rash.new
      raise 'Must Supply Vendor' unless @client.vendor
    end

    def all
      find_all(path: "#{@client.vendor}/listings")
    end

    def find(id)
      listing_attributes = @client.get("#{@client.vendor}/listings/#{id}")
      Retsly::Models::Listing.new(
        listing_attributes.merge(client: @client)
      )
    end

    def Map
      Retsly::Models::ListingMap.new(client: @client)
    end

    def where(params = {})
      valid_keys?(params.keys)
      valid_operators?(params_operators(params))
      @where_params.merge!(::Hashie::Rash.new(params))
      self
    end

    def where_query
      @where_params.to_camelback_keys.map do |key, expression|
        "&#{key.gsub(/Id$/, 'ID')}.#{expression.keys.first}=#{expression.values.last}"
      end.join
    end

    private

    def find_all(path:)
      @client.get(path, where_query).map do |vendor_attributes|
        Retsly::Models::Listing.new(
          vendor_attributes.merge(client: @client)
        )
      end
    end

    def params_operators(params)
      params.values.map(&:keys).flatten
    end

    def valid_operators?(operators)
      raise 'Invalid Operator' if (operators - OPERATORS).any?
      true
    end

    def valid_keys?(keys)
      raise 'Invalid Field' if (keys - Retsly::Models::Listing.attributes).any?
      true
    end
  end
end
