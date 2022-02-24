require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class GenerateDoiJob < ApplicationJob
  queue_as :doi

  def perform(objectId)

    work  = ActiveFedora::Base.find(objectId, cast: true)
    # If object is not a work, series or folio, do nothing
    if work.work?

      # check the list of bundle records, we don't want DOIs for them:
      #byebug
      if work.visibility == 'open'
          unless DoiBlockerLists.exists?(object_id: work.id)

              # If object has a DOI already, do nothing
              if work.doi.blank?
                # Build json for datacite
                #payload = JSON.generate(metadata_hash(work))
                payload = work.to_datacite_json
                puts 'PAYLOAD:' + payload
                # Build call to datacite, credentials in environment variables
                url = URI(Rails.application.config.datacite_service + 'dois')
                puts 'URL' + url.to_s
                http = Net::HTTP.new(url.host, url.port)
                http.use_ssl = true

                request = Net::HTTP::Post.new(url)
                request["Content-Type"] = 'application/vnd.api+json'
                request["Authorization"] = ENV['DATACITE_API_BASIC_AUTH']
                request.body = payload
                puts 'PAYLOAD' + payload
                response = http.request(request)
                puts 'RESPONSE CODE' + response.code
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
          end
        end
    end

  end

end
