# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.ignore_hosts 'elasticsearch'
  config.configure_rspec_metadata!

  config.default_cassette_options = {
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_params(:key, :address)
    ]
  }
end
