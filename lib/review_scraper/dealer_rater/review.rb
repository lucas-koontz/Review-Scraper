# frozen_string_literal: true

module ReviewScraper
  module DealerRater
    class Review
      def initialize(raw_element)
        @raw_element = raw_element
      end

      def content
        raw_element.search('p.review-content').first
      end

      private

      attr_reader :raw_element
    end
  end
end
