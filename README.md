# ReviewScraper

-- Status TODO --

This web scraper searches for "good" dealership's reviews on DealerRater.com for the Committee for State Security.

## Scenario

The KGB has noticed a resurgence of overly excited reviews for a McKaig Chevrolet Buick, a dealership they have planted in the United States. In order to avoid attracting unwanted attention, you’ve been enlisted to scrape reviews for this dealership from DealerRater.com and uncover the top three worst offenders of these overly positive endorsements.

Your mission, should you choose to accept it, is to write a tool that:

1. scrapes the first five pages of reviews
2. identifies the top three most “overly positive” endorsements (using criteria of your choosing, documented in the README)
3. outputs these three reviews to the console, in order of severity

## Table of Contents
- [ReviewScraper](#reviewscraper)
  - [Scenario](#scenario)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [How to Run](#how-to-run)
  - [Usage](#usage)
    - [DealerRater](#dealerrater)
  - [Examples](#examples)
  - [Test](#test)
  - [Score System for **DealerRater.com**](#score-system-for-dealerratercom)
  - [How to extract information](#how-to-extract-information)
  - [Contributing](#contributing)
  - [License](#license)
  - [Code of Conduct](#code-of-conduct)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'review_scraper'
```

And then execute:

`$ bundle install`

Or install it yourself as:

`$ gem install review_scraper`

## How to Run

There's several ways to run this project:

1. As an installed gem in a project (described above).
1. Run directly in your console after downloading this project.
   - `$ bundle install`
   - `$ bin/console`
1. As a docker container:
   - `$ docker-compose run review-scraper bin/console`


## Usage

```ruby
require 'review_scraper'
```

### DealerRater

Provide the url for a dealership's overview page on [DealerRater.com](https://www.dealerrater.com/). Use the search box at the top right corner to find an overview page.


Create a new client:
```ruby
dealer_scraper = ReviewScraper::DealerRater::Client.new(url: <String>)
```

Scrape the first review page:
```ruby
dealer_scraper.scrape_first # <= returns an array of ReviewScraper::DealerRater::Review
```

Scrape a range of pages. `start_page` default value is 1.
```ruby
dealer_scraper.scrape_range(start_page: <Integer>, stop_page: <Integer>) # <= returns an array of ReviewScraper::DealerRater::Review
```


## Examples

Creating a new client:
```ruby
dealer_url = "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/"

dealer_scraper = ReviewScraper::DealerRater::Client.new(url: dealer_url)
```



## Test

$ rspec

## Score System for **DealerRater.com**

All information used into this scoring system was extract from online review pages. After analysing DealerRater's html it was possible to detect how their website is formatted.

This is an MVP, thus this tool only analyses a review's message  and the average given by a customer.


## How to extract information

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lucasfernand-es/review_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/review_scraper/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReviewScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/review_scraper/blob/master/CODE_OF_CONDUCT.md).
