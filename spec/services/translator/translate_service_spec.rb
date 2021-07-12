# frozen_string_literal: true

require 'rails_helper'

describe Translator::TranslateService do
  subject(:service) { described_class.new(text, target_language) }

  let(:api_key) { 'api123' }
  let(:text) { 'Hello World!' }
  let(:target_language) { 'pt-BR' }

  before do
    allow(ENV).to receive(:fetch).and_return(api_key)
  end

  context 'when success' do
    let(:expected_translation) { 'Olá Mundo!' }

    before do
      allow(EasyTranslate).to receive(:translate).with(text, to: target_language).and_return(expected_translation)
    end

    it 'returns the expected translation' do
      expect(EasyTranslate).to receive(:translate).with(text, to: target_language).and_return(expected_translation)
      expect(service.perform).to be_success
      expect(service.perform.translation).to eq(expected_translation)
    end
  end

  context 'when fail' do
    let(:expected_translation) { '' }

    before do
      allow(EasyTranslate).to receive(:translate).with(text, to: target_language).and_return(expected_translation)
    end

    it 'returns service failure' do
      expect(EasyTranslate).to receive(:translate).with(text, to: target_language).and_return(expected_translation)
      expect(service.perform).to be_a_failure
    end
  end
end
