# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Translators', type: :request do
  describe 'POST /api/v1/translator' do
    subject(:translator_request) do
      post api_v1_translator_index_path(params)
    end

    context 'when success' do
      let(:params) do
        {
          translator: {
            text: 'Hello World!',
            target_language: 'pt-BR'
          }
        }
      end

      let(:json_response) { JSON.parse(response.body) }

      let(:translation) { json_response['translation'] }

      it 'returns the correct status code' do
        translator_request

        expect(response).to have_http_status(:ok)
        expect(translation).to eq('Olá Mundo!')
      end
    end

    context 'when error' do
      let(:params) do
        {
          translator: {
            text: '',
            target_language: 'pt-BR'
          }
        }
      end

      let(:json_response) { JSON.parse(response.body) }

      it 'returns the correct status code' do
        translator_request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to be_kind_of(Hash)
      end
    end
  end
end
