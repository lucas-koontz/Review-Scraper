# frozen_string_literal: true

require 'review_scraper'

RSpec.describe ReviewScraper::DealerRater::Client do
  let(:url) { nil }

  subject { described_class.new(url: url) }

  let(:reviews_per_page) { 10 }
  let(:reviews_stop_page) { 3 }

  let(:url_overview) { 'https://www.dealerrater.com/dealer/dealership-review-id/' }
  let(:fixture_overview) { 'spec/fixtures/dealer_rater/overview_page.htm' }

  let(:url_review) { 'https://www.dealerrater.com/dealer/dealership-reviews-id/' }
  let(:fixture_review) { 'spec/fixtures/dealer_rater/review_page.htm' }

  let(:fixture_last_review) { 'spec/fixtures/dealer_rater/review_last_page.htm' }

  before do
    stub_page(url: url_overview, fixture: fixture_overview)
    stub_page(url: url_review, fixture: fixture_review)
  end

  context 'when successfuly scraping a dealership\'s reviews page' do
    let(:url) { url_overview }

    it 'should scrape the first review page' do
      mock_review_page(page_number: 1)

      response = subject.scrape_first

      expect(response).to be_a(Array)
      expect(response).to all(be_a(ReviewScraper::DealerRater::Review))
    end

    it 'should scrape a range of pages starting on first page' do
      stop_page = 5

      mock_review_page_range(start_page: 1, stop_page: stop_page)

      response = subject.scrape_range(stop_page: stop_page)

      expect(response).to be_a(Array)
      expect(response).to all(be_a(ReviewScraper::DealerRater::Review))
    end

    it 'should scrape a range of review pages not starting on first page' do
      start_page = 10
      stop_page = 15

      mock_review_page_range(start_page: start_page, stop_page: stop_page)

      response = subject.scrape_range(start_page: start_page, stop_page: stop_page)

      expect(response).to be_a(Array)
      expect(response).to all(be_a(ReviewScraper::DealerRater::Review))
    end

    it 'should scrape a range of review pages including last page' do
      start_page = 1
      stop_page = 15

      mock_review_page_range(start_page: start_page, stop_page: stop_page)

      stub_last_page = mock_review_last_page(last_page: stop_page)
      stub_after_last_page = mock_review_page(page_number: stop_page + 1)

      response = subject.scrape_range(start_page: start_page, stop_page: stop_page)

      expect(response).to be_a(Array)
      expect(response).to all(be_a(ReviewScraper::DealerRater::Review))

      assert_requested(stub_last_page)
      assert_not_requested(stub_after_last_page)
    end

    it 'should scrape all reviews' do
      start_page = 1
      stop_page = 10

      mock_review_page_range(start_page: start_page, stop_page: stop_page)

      stub_last_page = mock_review_last_page(last_page: stop_page)
      stub_after_last_page = mock_review_page(page_number: stop_page + 1)

      response = subject.scrape_all

      expect(response).to be_a(Array)
      expect(response).to all(be_a(ReviewScraper::DealerRater::Review))

      assert_requested(stub_last_page)
      assert_not_requested(stub_after_last_page)
    end
  end

  context 'when an error occur while scraping a dealership\'s reviews page' do
    it 'should raise an error when trying to scrape a page with an index lower than 1' do
      expect do
        subject.scrape_range(start_page: 0, stop_page: 200)
      end.to raise_error(ReviewScraper::InvalidPageRange)
    end

    it 'should raise an error when trying to scrape a page with an stop page index lower'\
                                                                 ' than start page index' do
      expect do
        subject.scrape_range(start_page: 3, stop_page: 2)
      end.to raise_error(ReviewScraper::InvalidPageRange)
    end
  end
  ### Helper stubs

  def stub_page(url:, fixture:)
    stub_request(:get, url)
      .to_return(status: 200,
                 body: File.new(fixture),
                 headers: { 'Content-Type' => 'text/html' })
  end

  def mock_review_page_url(page_number:)
    url_review + "page#{page_number}"
  end

  def mock_review_page(page_number:)
    url = mock_review_page_url(page_number: page_number)
    stub_page(url: url, fixture: fixture_review)
  end

  def mock_review_last_page(last_page:)
    url = mock_review_page_url(page_number: last_page)
    stub_page(url: url, fixture: fixture_last_review)
  end

  def mock_review_page_range(start_page:, stop_page:)
    (start_page..stop_page).each do |index|
      mock_review_page(page_number: index)
    end
  end
end
