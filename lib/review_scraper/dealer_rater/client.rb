# frozen_string_literal: true

module ReviewScraper
  module DealerRater
    class Client
      def initialize(url:)
        @base_url = url
      end

      def scrape_first
        scrape_range(stop_page: 1)
      end

      def scrape_all
        scrape_range(start_page: 1, stop_page: Float::INFINITY)
      end

      def scrape_range(stop_page:, start_page: 1)
        if start_page < 1
          raise ReviewScraper::InvalidPageRange,
                'Start page index needs to be at least 1.'
        end
        if start_page > stop_page
          raise ReviewScraper::InvalidPageRange,
                'Stop Page index needs to be greater or equal to Start Page index'
        end

        reviews = []

        (start_page..stop_page).each do |index|
          page = review_page(page_number: index)

          reviews << fetch_reviews(page: page)

          break if last_review_page?(page: page) # Stop Condition
        end

        reviews.flatten
      end

      private

      attr_reader :base_url

      def agent
        @agent ||= Mechanize.new
      end

      def connect(url: base_url)
        agent.get(url)
      end

      def reviews_page
        @reviews_page ||= connect.link_with(text: /Reviews \(.+\)/).click
      end

      def reviews_page_base_url
        @reviews_page_base_url ||= reviews_page.canonical_uri.to_s
      end

      def page_suffix(page_number: 1)
        format('page%s', page_number)
      end

      def fetch_reviews(page:)
        page.search('div.review-entry').map do |review|
          ReviewScraper::DealerRater::Review.new(review)
        end
      end

      def review_page(page_number: 1)
        connect(url: reviews_page_base_url + page_suffix(page_number: page_number))
      end

      def last_review_page?(page:)
        !page.search('div.page_inactive.next.page').empty?
      end
    end
  end
end
