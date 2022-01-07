class SendDoiToSierraJob < ApplicationJob
  queue_as :export
  require 'net/http'

  def perform(*args)

    # Add XML header
    our_xml = marcxml_header

    @max_rows = 15000
    max_rows_exceeded = ""

    if ENV["RAILS_ENV"] != 'test'
      # Run Solr query
      h = Net::HTTP.new(Rails.application.config.solr_vm, Rails.application.config.solr_port)
      #http_response = h.get('http://' + Rails.application.config.solr_vm + ':' + Rails.application.config.solr_port + '/solr/tcd-hyrax/select?q=doi_tesim:*' + Rails.application.config.doi_prefix + '*%20AND%20dris_unique_tesim:[*%20TO%20*]&rows=' + @max_rows.to_s)

      http_response = h.get('http://' + Rails.application.config.solr_vm + ':' + Rails.application.config.solr_port + '/solr/tcd-hyrax/select?q=doi_tesim:*' + Rails.application.config.doi_prefix + '*%20AND%20dris_unique_tesim:b*&rows=' + @max_rows.to_s)

      # JL : to do: this eval doesn't work in test rspec. Why not?
      rsp = eval(http_response.body)

      #puts 'number of matches = ' + rsp[:response][:numFound].to_s
      if rsp[:response][:numFound] > @max_rows
        puts 'number of matches = ' + rsp[:response][:numFound].to_s
        max_rows_exceeded = "Query returned more than " + @max_rows.to_s + " records. Need to increase @max_rows in app/jobs/send_doi_to_sierra_job.rb."
      end

      # Add XML records
      rsp[:response][:docs].each { |doc|
        our_xml << marcxml_leader(doc)
        our_xml << marcxml_record(doc)
      }
    end
    # Add XML trailer
    our_xml << marcxml_trailer

    # Open file and write the xml
    File.open(Rails.application.config.export_folder + "DOIs_To_Sierra.xml", "w") { |f| f.write our_xml }

    # Mail me, Michelle, Charles
    DoiToSierraMailer.doi_to_sierra_email(max_rows_exceeded).deliver_later

  end

  private

  def marcxml_header
    "<?xml version='1.0' encoding='UTF-8' ?>\n<marc:collection xmlns:marc='http://www.loc.gov/MARC21/slim' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd'>\n<marc:record>\n"
  end

  def marcxml_trailer
    "</marc:record>\n</marc:collection>"
  end

  def marcxml_leader(doc)
    "<marc:leader>" + doc[:dris_unique_tesim].first.to_s + "</marc:leader>\n"
  end

  def marcxml_record(doc)
   #"dris_unique field = " + doc[:dris_unique_tesim].first.to_s + " doi field = " + doc[:doi_tesim].first.to_s + "\n"
   "<marc:datafield tag='907' ind2=' ' ind1=' '><marc:subfield code='a'>." + doc[:dris_unique_tesim].first.to_s + "</marc:subfield> </marc:datafield>\n" +
   "<marc:datafield tag='856' ind2='0' ind1='4'><marc:subfield code='u'>" + doc[:doi_tesim].first.to_s + "</marc:subfield> </marc:datafield>\n"
  end

end
