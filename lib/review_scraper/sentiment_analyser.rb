# frozen_string_literal: true

module ReviewScraper
  class SentimentAnalyser < ServiceBase
    THRESHOLD = 0.25

    def call(text:, modifier: 1)
      score = analyzer.score text

      score * modifier
    end

    private

    def analyzer
      analyzer = Sentimental.new
      analyzer.load_defaults
      analyzer.threshold = THRESHOLD

      @analyzer ||= analyzer
    end
  end
end
