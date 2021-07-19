# frozen_string_literal: true

module Api
  module V1
    class TranslatorController < ApplicationController
      def create
        Translator::TranslateService.perform(text, target_language).yield_self do |result|
          if result.success?
            render json: { translation: result.translation }, status: :ok
          else
            render json: { errors: ['Failure'] }, status: :unprocessable_entity
          end
        end
      end

      private

      def text
        translate_params[:text]
      end

      def target_language
        translate_params[:target_language]
      end

      def translate_params
        params.require(:translator).permit(:text, :target_language)
      end
    end
  end
end
