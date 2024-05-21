# frozen_string_literal: true

# Finds or creates a job record
class SaveRecord
  def self.call(attributes)
    job = Job.find_or_create_by(url: attributes.url)

    # update with latest attributes
    job.update(
      company_name: attributes.company_name,
      title: attributes.title,
      url: attributes.url
    )
  end
end
