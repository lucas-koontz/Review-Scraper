# frozen_string_literal: true

module ReviewScraper
  class ServiceBase
    def self.call(*args)
      new.call(*args)
    end
  end
end
