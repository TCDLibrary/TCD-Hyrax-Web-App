# Override from Hyrax v3.0.0.pre.rc3
# The pul_uv_rails gem has been replaced in Hyrax,
# see this PR: https://github.com/samvera/hyrax/pull/3696

# frozen_string_literal: true
module Hyrax
  module IiifHelper
    def iiif_viewer_display(work_presenter, locals = {})
      render iiif_viewer_display_partial(work_presenter),
             locals.merge(presenter: work_presenter)
    end

    def iiif_viewer_display_partial(work_presenter)
      'hyrax/base/iiif_viewers/' + work_presenter.iiif_viewer.to_s
    end

    def universal_viewer_base_url
      "#{request&.base_url}/uv/uv.html"
    end

    def universal_viewer_config_url
      "#{request&.base_url}/uv/uv-config.json"
    end
  end
end
