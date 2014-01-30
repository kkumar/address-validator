require 'forwardable'

module AddressValidator
  class Response
    extend Forwardable

    attr_reader :api_response
    def_delegators :api_response, :[]

    def initialize(api_response)
      @api_response = api_response
    end

    def ok?
      @api_response.ok?
    end

    def success?
      ok? && response['Response']['ResponseStatusCode'] == '1'
    end

    def response
      @response ||= self['AddressValidationResponse']
    end

    def valid?
      response.has_key?('ValidAddressIndicator')
    end

    def ambiguous?
      response.has_key?('AmbiguousAddressIndicator')
    end

    def no_canidates?
      response.has_key?('NoCandidatesIndicator')
    end
  end
end
