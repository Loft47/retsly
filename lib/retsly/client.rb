module Retsly
  # rubocop:disable Style/MethodName
  class Client
    BASE_URI = 'https://rets.io/api/v1/'.freeze

    attr_accessor :access_token
    attr_accessor :vendor

    def initialize(access_token:, vendor: nil)
      @access_token = access_token
      @vendor = vendor
      raise 'Acces Token required' unless @access_token
    end

    def get(page, query_params = nil)
      raise 'A Page is required' unless page
      json = ::JSON.parse(raw(page, query_params))
      response = ::Hashie::Rash.new(json)
      api_failure(response) unless response.success == true
      response.bundle
    end

    def raw(page, query_params = nil)
      Net::HTTP.get(URI.parse("#{BASE_URI}#{page}?access_token=#{@access_token}#{query_params}"))
    end

    def Vendor
      Retsly::Vendor.new(client: self)
    end

    def Listing
      Retsly::Listing.new(client: self)
    end

    def api_failure(response)
      raise "API Error: #{response.status} :: #{[response.bundle.name, response.bundle.message].join('-')}"
    end
  end
end
