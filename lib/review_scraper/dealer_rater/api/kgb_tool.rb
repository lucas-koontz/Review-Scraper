# frozen_string_literal: true

module ReviewScraper
  module DealerRater
    module Api
      module KgbTool
        class << self
          URL = 'https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/'

          def print_top_offenders(num_offenders)
            top_offenders = sorted_reviews.first(num_offenders)

            top_offenders.each_with_index do |review, index|
              puts "#{index + 1}. \tOffense: '#{review.content}'"\
                   "\n\tOffense score: #{review.score}\n\tBy #{review.author}"
            end

            nil
          end

          def print_top_three_offenders
            print_top_offenders(3)
          end

          def reviews
            @reviews ||= client.scrape_range(stop_page: 5)
          end

          def sorted_reviews
            @sorted_reviews ||= reviews.sort_by(&:score).reverse # Sorted by positive score
          end

          private

          def client
            @client ||= ReviewScraper::DealerRater::Client.new(url: URL)
          end
        end
      end
    end
  end
end
