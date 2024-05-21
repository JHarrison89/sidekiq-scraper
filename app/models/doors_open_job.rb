# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

# scraps a web page and returns
# a valid job, or false
class DoorsOpenJob
  def self.call(url: 'https://www.doorsopen.co/job/6289/product-manager/')
    @url = url
    scrape
  end

  private

  def scrape
    # downloading the target web page
    response = HTTParty.get(@url)

    # parsing the HTML document returned by the server
    doc = Nokogiri::HTML(response.body)

    # job title
    title = doc.css('.details-header__title').text.strip

    Struct.new('Result', :company_name, :title)

    Struct::Result.new(
      company_name: 'Doors Open',
      title:
    )
  end
end
