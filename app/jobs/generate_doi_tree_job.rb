class GenerateDoiTreeJob < ApplicationJob
  queue_as :doi

  def perform(work)

    prep_for_doi_job(work)

  end

  private

  def prep_for_doi_job(work, id_cache = [])

    #obj = ActiveFedora::Base.find(objectId, cast: true)
    #byebug
    if work.work?

      if work.visibility == 'open'
          unless DoiBlockerLists.exists?(object_id: work.id)
          # GenerateDoiJob.perform_later(work)
            # If object has a DOI already, do nothing
            if work.doi.blank?
              # Build json for datacite
              #payload = JSON.generate(metadata_hash(work))
              payload = work.to_datacite_json

              # Build call to datacite, credentials in environment variables
              url = URI(Rails.application.config.datacite_service + 'dois')

              http = Net::HTTP.new(url.host, url.port)
              http.use_ssl = true

              request = Net::HTTP::Post.new(url)
              request["Content-Type"] = 'application/vnd.api+json'
              request["Authorization"] = ENV['DATACITE_API_BASIC_AUTH']
              request.body = payload

              response = http.request(request)

              puts response.read_body
              # Check response, handle any errors, update the work with the doi value
              # work.doi = "kjkjj" + work.id
              if ["200", "201", '202'].include? response.code
                 #byebug
                 work.doi = Rails.application.config.doi_org_url + Rails.application.config.doi_prefix + '/' + work.id
                 work.save
                 #byebug
              end
            end
          end # unless
        end # if work.visibility == 'open'

      if work.members.size > 0
      # need to go down through the tree recursively
      # id_cache is built up to prevent recursive loops
        work.members.each_with_index do | child, i |
          unless id_cache.include? child.id
              id_cache << child.id
              prep_for_doi_job(child, id_cache)
          end
        end
      end

    end
  end
end
