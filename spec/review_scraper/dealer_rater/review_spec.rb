# frozen_string_literal: true

require 'review_scraper'

RSpec.describe ReviewScraper::DealerRater::Review do
  let(:content) { 'Review Content' }
  let(:rating) { 48 }
  let(:author) { 'Author' }

  let(:review_element) do
    fixture_overview = 'spec/fixtures/dealer_rater/review_page.htm'
    doc = File.open(fixture_overview) { |f| Nokogiri::HTML(f) }
    doc.at('div.review-entry')
  end

  subject { described_class.new(review_element) }

  it 'should extract the content from a review' do
    expect(subject.content).to eq('Review Content')
  end

  it 'should extract the rating from a review' do
    expect(subject.rating).to eq(48)
  end

  it 'should return a review score' do
    expect(subject.score).to be_truthy
  end

  it 'should return a review author' do
    expect(subject.author).to eq('Author')
  end
end
