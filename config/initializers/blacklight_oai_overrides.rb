BlacklightOaiProvider::Controller.module_eval do
  def oai
    body = oai_provider
      .process_request(oai_params.to_h)
    render xml: body, content_type: 'text/xml'
  end
end
