# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
class Script
  def self.call(url:); end
end

RSpec.describe ScrapeWebpageJob, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  describe '#perform' do
    let(:url) { 'doorsopen/first_job' }
    let(:attributes) { OpenStruct.new(company_name: 'NVS', title: 'Ticketing Manager', url:) }
    let(:script) { Script }

    before { allow(script).to receive(:call).and_return(attributes) }

    context 'when given new job attributes' do
      it 'creates a new job record' do
        expect { subject.perform(script: script.name, url:) }
          .to change(Job, :count).by(1)

        expect(Job.last).to have_attributes(
          company_name: attributes.company_name,
          title: attributes.title,
          url: attributes.url
        )
      end

      describe 'attributes for an existing job' do
        it 'finds and updates the job' do
          travel_to(1.month.ago)
          Job.create(company_name: 'job record', title: 'that exists already', url:)
          travel_back

          expect { subject.perform(script: script.name, url:) }
            .to change(Job, :count).by(0)
        end
      end
    end
  end
end
