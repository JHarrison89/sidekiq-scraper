# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
class Script
  def self.call(url:); end
end

RSpec.describe ScrapeWebpageJob, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  describe '#perform' do
    let(:webpage) { OpenStruct.new(company_name: 'NVS', title: 'Ticketing Manager') }
    let(:script) { Script }
    let(:url) { 'doorsopen/first_job' }

    before { allow(script).to receive(:call).and_return(webpage) }

    context 'when given new attributes' do
      it 'creates a new job record' do
        expect { ScrapeWebpageJob.new.perform(script: script.name, url:) }
          .to change(Job, :count).by(1)

        expect(Job.last).to have_attributes(
          company_name: webpage.company_name,
          title: webpage.title,
          url:
        )
      end
    end

    context 'when given existing attributes' do
      before { Job.create(company_name: 'job record', title: 'that exists already', url:) }
      it 'finds and updates the job' do
        expect { ScrapeWebpageJob.new.perform(script: script.name, url:) }
          .to change(Job, :count).by(0)
      end
    end
  end
end
