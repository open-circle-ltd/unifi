# frozen_string_literal: true
require 'ostruct'
require 'json'
require_relative '../lib/unifi/client/response_normalizer'

describe Unifi::Client::ResponseNormalizer do
  let(:dummy_class) { Class.new { include Unifi::Client::ResponseNormalizer } }
  let(:instance) { dummy_class.new }

  it 'returns parsed hash for valid JSON response' do
    response = OpenStruct.new(parsed_response: { 'foo' => 'bar' }, code: 200)
    expect(instance.send(:normalize_unifi_response, response)).to eq({ 'foo' => 'bar' })
  end

  it 'returns error hash for HTTP 500+' do
    response = OpenStruct.new(parsed_response: 'Internal Server Error', code: 502)
    expect(instance.send(:normalize_unifi_response, response)).to eq({
      'errorCode' => 502,
      'message' => 'UniFi API error (HTTP 502)'
    })
  end

  it 'returns error hash for unexpected response shape' do
    response = OpenStruct.new(parsed_response: 'not a hash', code: 200)
    expect(instance.send(:normalize_unifi_response, response)).to eq({
      'errorCode' => -1,
      'message' => 'Unexpected UniFi API response'
    })
  end
end
