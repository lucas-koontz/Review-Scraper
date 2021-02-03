# frozen_string_literal: true

require 'review_scraper'

RSpec.describe ReviewScraper::SentimentAnalyser do
  let(:good_sentiment) { 'I love something.' }
  let(:bad_sentiment) { 'I hate something.' }

  it 'should classify sentiments in a text correctly' do
    good_score = described_class.call(text: good_sentiment)
    bad_score = described_class.call(text: bad_sentiment)

    expect(good_score).to be > bad_score
  end

  it 'should be able to modify a score' do
    good_score = described_class.call(text: good_sentiment)
    good_score_modified = described_class.call(text: good_sentiment, modifier: 2)

    expect(good_score_modified).to be > good_score
  end
end
