# JL 02/04/2019 Cloned from https://github.com/UNC-Libraries/hy-c. Thanks to Dean Farrell at UNC Libraries

module ParentQueryService
  def self.query_parents_for_id(child_id)
    ActiveFedora::SolrService.get("member_ids_ssim:#{child_id}", :rows => 1000)["response"]["docs"]
  end
end
