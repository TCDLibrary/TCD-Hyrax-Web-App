class DeleteDraftDoiJob < ApplicationJob
  queue_as :doi
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def perform(work)

    # If object is not a work, series or folio, do nothing
    if work.work?
        url = URI(Rails.application.config.datacite_service  + 'dois/' + Rails.application.config.doi_prefix + '%2F' + work.id)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Delete.new(url)
        request["Authorization"] = ENV['DATACITE_API_BASIC_AUTH']

        response = http.request(request)

        if ["200", "201", '202', '204'].include? response.code
           work.doi = ''
        end
    end 
  end

end
