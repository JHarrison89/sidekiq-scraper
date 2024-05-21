# frozen_string_literal: true

# Queues up a
class ScrapeWebpageJob
  include Sidekiq::Job

  def perform(script:, url:)
    # Convert script string name to Object
    script = Object.const_get(script)

    # Scrape webspage and return result
    attributes = script.call(url:)

    # find or create job record
    SaveRecord.call(attributes)
  end
end
