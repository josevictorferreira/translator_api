# frozen_string_literal: true

module Translator
  class TranslateService < Aldous::Service
    attr_reader :text, :target_language

    def initialize(text, target_language)
      @text = text
      @target_language = target_language
      EasyTranslate.api_key = api_key
    end

    def perform
      if translation.present?
        Result::Success.new(translation: translation)
      else
        Result::Failure.new
      end
    end

    private

    def translation
      @translation ||= EasyTranslate.translate(text, to: target_language)
      @translation
    end

    def api_key
      ENV.fetch('GOOGLE_API_KEY')
    end
  end
end
