# ReviewScraper

[![Actions Status](https://github.com/lucasfernand-es/Review-Scraper/workflows/build/badge.svg)](https://github.com/lucasfernand-es/Review-Scraper/actions)

This web scraper searches for "good" dealership reviews on DealerRater.com for the Committee for State Security.

## Table of Contents
  - [Scenario](#scenario)
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


## Scenario

The KGB has noticed a resurgence of overly excited reviews for a McKaig Chevrolet Buick, a dealership they have planted in the United States. In order to avoid attracting unwanted attention, you’ve been enlisted to scrape reviews for this dealership from DealerRater.com and uncover the top three worst offenders of these overly positive endorsements.

Your mission, should you choose to accept it, is to write a tool that:

1. Scrapes the first five pages of reviews
2. Identifies the top three most “overly positive” endorsements (using criteria of your choosing, documented in the README)
3. Autputs these three reviews to the console, in order of severity

### Proposed solution

It developed an API to help the KGB identify "the top three worst offenders" called `ReviewScraper::DealerRater::Api::KgbTool`. All the agent needs to do is run a function `print_top_three_offenders` to print these offenders' comments in the console.

```ruby
ReviewScraper::DealerRater::Api::KgbTool.print_top_three_offenders
=begin
1.  Offense: '<content>'
    Offense score: <score>
    By <author>
2.  Offense: '<content>'
    Offense score: <score>
    By <author>
3.  Offense: '<content>'
    Offense score: <score>
    By <author>
=> nil
=end

```

#### Running without docker

Make sure to have installed Ruby v2.7.2 in your console, then run:
```bash
$ bundle install
$ bin/console
```

#### Running with docker

```bash
$ docker-compose run review-scraper bin/console
```

Once inside the `bin/console` run:
```ruby
ReviewScraper::DealerRater::Api::KgbTool.print_top_three_offenders
```

**NOTE**: In-depth details about this application are described below.

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

There are several ways to run this project:

1. As an installed gem in a project (described above).
1. Run directly in your console after downloading this project.
   - `$ bundle install`
   - `$ bin/console`
  
2. As a [docker](https://www.docker.com/) container:
   - `$ docker-compose run review-scraper bin/console`


ReviewScraper::DealerRater::Api::KgbTool.print_top_three_offenders


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

Scrape all pages. 
```ruby
dealer_scraper.scrape_all # <= returns an array of ReviewScraper::DealerRater::Review
```


## Examples

Creating a new client:
```ruby
dealer_url = "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/"

dealer_scraper = ReviewScraper::DealerRater::Client.new(url: dealer_url)
```

## Test

`$ rspec`

## Score System for **DealerRater.com**

Reviews content is analysed in  `ReviewScraper::SentimentAnalyser` which uses [Sentimental](https://github.com/7compass/sentimental) to verify how positive an endorsement is.

We are encapsulating this service so any other analysis tool can be easily implemented in the future.

`ReviewScraper::SentimentAnalyser` is a service that receives a `text` and a `modifier` and returns a score. For DealerRater:
- `text`: content of a review.
- `modifier`: the average rating is given by a customer.

`text` is analyzed by each word and not the sentence. So at this time, complex sentences (e.g. containing sarcasm) might be misinterpreted.

A review score is determined as follows:
```ruby
score = <review sentiment score> * rating
```

The overall sentiment of a review is given by a set threshold:

- Positive scores are > 0.25
- Neutral scores are <= 0.25 and >= -0.25
- Negative scores are < -0.25

Since we are only handling reviews from DealerRater.com, we did not worry about normalizing/standardizing our data.


**NOTE**: All information used in this scoring system was extracted from online review pages. After analysing DealerRater's html it was possible to detect how their website is formatted.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lucasfernand-es/review_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lucasfernand-es/review_scraper/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReviewScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/review_scraper/blob/master/CODE_OF_CONDUCT.md).
