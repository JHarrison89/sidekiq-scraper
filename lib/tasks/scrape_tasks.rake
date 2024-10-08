# frozen_string_literal: true

namespace :scrape_tasks do
  desc 'Scrape show pages'
  task scrape_show_pages: :environment do
    JobShow.all.each { ScrapeJobShowJob.perform_async(_1.id) }
  end

  desc 'Scrape index pages'
  task scrape_index_pages: :environment do
    IndexPages.constants.each do |index_page|
      Object.const_get("IndexPages::#{index_page}").call
    end
  end
end
