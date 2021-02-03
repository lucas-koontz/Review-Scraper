# frozen_string_literal: true

module ReviewScraper
  module DealerRater
    class Review
      attr_reader :raw_element

      # <= Nokogiri::XML::Element
      def initialize(raw_element)
        @raw_element = raw_element
      end

      def content
        @content ||= raw_element.at('p.review-content').children.text
      end

      def rating
        element = raw_element.at('div.dealership-rating')

        @rating ||= extract_rating_from_element(element)
      end

      private

      def extract_rating_from_element(element)
        classes = element.at('div[class^="rating-"]').values.first
        classes[/.*rating-([^ ]*)/, 1].to_f
      end
    end
  end
end
