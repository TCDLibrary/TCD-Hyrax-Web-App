module Hyrax
  module HyraxHelperBehavior
    include Hyrax::CitationsBehavior
    include ERB::Util # provides html_escape
    include Hyrax::TitleHelper
    include Hyrax::FileSetHelper
    include Hyrax::AbilityHelper
    include Hyrax::UrlHelper
    include Hyrax::EmbargoHelper
    include Hyrax::LeaseHelper
    include Hyrax::CollectionsHelper
    include Hyrax::ChartsHelper
    include Hyrax::DashboardHelperBehavior
    include Hyrax::IiifHelper

    # Which translations are available for the user to select
    # @return [Hash<String,String>] locale abbreviations as keys and flags as values
    def available_translations
      {
        'de' => 'Deutsch',
        'en' => 'English',
        'es' => 'Español',
        'fr' => 'Français',
      #  'ga' => 'Gaeilge',  # JL : hide for now
        'it' => 'Italiano',
        'pt-BR' => 'Português do Brasil',
        'zh' => '中文'
      }
    end

    delegate :name, :name_full, to: :institution, prefix: :institution

    def banner_image
      Hyrax.config.banner_image
    end

    def orcid_label(style_class = '')
      safe_join([image_tag('orcid.png', alt: t('hyrax.user_profile.orcid.alt'), class: style_class),
                 t('hyrax.user_profile.orcid.label')], ' ')
    end

    def zotero_label(opts = {})
      html_class = opts[:html_class] || ''
      safe_join([image_tag('zotero.png', alt: t('hyrax.user_profile.zotero.alt'), class: html_class),
                 t('hyrax.user_profile.zotero.label')], ' ')
    end

    def zotero_profile_url(zotero_user_id)
      "https://www.zotero.org/users/#{zotero_user_id}"
    end

    # @param [User] user
    def render_notifications(user:)
      mailbox = UserMailbox.new(user)
      unread_notifications = mailbox.unread_count
      link_to(hyrax.notifications_path,
              'aria-label' => mailbox.label(params[:locale]),
              class: 'notify-number') do
        capture do
          concat content_tag(:span, '', class: 'fa fa-bell')
          concat "\n"
          concat content_tag(:span,
                             unread_notifications,
                             class: count_classes_for(unread_notifications))
        end
      end
    end

    # @param [ProxyDepositRequest] req
    def show_transfer_request_title(req)
      if req.deleted_work? || req.canceled?
        req.to_s
      else
        link_to(req.to_s, [main_app, req.work])
      end
    end

    # @param item [Object]
    # @param field [String]
    # @return [ActiveSupport::SafeBuffer] the html_safe link
    def link_to_facet(item, field)
      path = main_app.search_catalog_path(search_state.add_facet_params_and_redirect(field, item))
      link_to(item, path)
    end

    # @param values [Array{String}] strings to display
    # @param solr_field [String] name of the solr field to link to, without its suffix (:facetable)
    # @param empty_message [String] message to display if no values are passed in
    # @param separator [String] value to join with
    # @return [ActiveSupport::SafeBuffer] the html_safe link
    def link_to_facet_list(values, solr_field, empty_message = "No value entered", separator = ", ")
      return empty_message if values.blank?
      facet_field = Solrizer.solr_name(solr_field, :facetable)
      safe_join(values.map { |item| link_to_facet(item, facet_field) }, separator)
    end

    # @param name [String] field name
    # @param value [String] field value
    # @param label [String] defaults to value
    # @param facet_hash [Hash] first argument to Blacklight::SearchState.new
    # @return [ActiveSupport::SafeBuffer] the html_safe link
    # @see Blacklight::SearchState#initialize
    def link_to_field(name, value, label = nil, facet_hash = {})
      label ||= value
      params = { search_field: name, q: "\"#{value}\"" }
      state = search_state_with_facets(params, facet_hash)
      link_to(label, main_app.search_catalog_path(state))
    end

    ## GROUP: helper_methods

    # A Blacklight helper_method
    # @param [Hash] options from blacklight invocation of helper_method
    # @see #index_field_link params
    # @return [Date]
    def human_readable_date(options)
      value = options[:value].first
      Date.parse(value).to_formatted_s(:standard)
    end

    # A Blacklight helper_method
    # @param options [Hash{Symbol=>Object}] Blacklight sends :document, :field, :config, :value and whatever else was in options
    # @option options [Array{String}] :value
    # @option options [Hash] :config including {:field_name => "my_name"}
    # @option options [Hash] :document
    # @option options [Array{String}] :value the strings you might otherwise have passed to this method singly
    # @return [ActiveSupport::SafeBuffer] the html_safe link
    def index_field_link(options)
      raise ArgumentError unless options[:config] && options[:config][:field_name]
      name = options[:config][:field_name]
      links = options[:value].map { |item| link_to_field(name, item, item) }
      safe_join(links, ", ")
    end

    # A Blacklight helper_method
    #
    # @example
    #   link_to_each_facet_field({ value: "Imaging > Object Photography", config: { helper_facet: :document_types_sim }})
    #   ```html
    #   <a href=\"/catalog?f%5Bdocument_types_sim%5D%5B%5D=Imaging\">Imaging</a> &gt; <a href=\"/catalog?f%5Bdocument_types_sim%5D%5B%5D=Object+Photography\">Object Photography</a>
    #   ```
    #
    # @param options [Hash] from blacklight invocation of helper_method
    # @option options [Array<#strip>] :value
    # @option options [Hash>] :config Example: { separator: '>', helper_facet: :document_types_sim, output_separator: '::' }
    # @return the html_safe facet links separated by the given separator (default: ' > ') to indicate facet hierarchy
    #
    # @raise KeyError when the options are note properly configured
    def link_to_each_facet_field(options)
      config = options.fetch(:config)
      separator = config.fetch(:separator, ' > ')
      output_separator = config.fetch(:output_separator, separator)
      facet_search = config.fetch(:helper_facet)
      facet_fields = Array.wrap(options.fetch(:value)).first.split(separator).map(&:strip)

      facet_links = facet_fields.map do |type|
        link_to(type, main_app.search_catalog_path(f: { facet_search => [type] }))
      end
      safe_join(facet_links, output_separator)
    end

    # Uses Rails auto_link to add links to fields
    #
    # @param field [String,Hash] string to format and escape, or a hash as per helper_method
    # @option field [SolrDocument] :document
    # @option field [String] :field name of the solr field
    # @option field [Blacklight::Configuration::IndexField, Blacklight::Configuration::ShowField] :config
    # @option field [Array] :value array of values for the field
    # @param show_link [Boolean]
    # @return [ActiveSupport::SafeBuffer]
    # @todo stop being a helper_method, start being part of the Blacklight render stack?
    def iconify_auto_link(field, show_link = true)
      if field.is_a? Hash
        options = field[:config].separator_options || {}
        text = field[:value].to_sentence(options)
      else
        text = field
      end
      # this block is only executed when a link is inserted;
      # if we pass text containing no links, it just returns text.
      auto_link(html_escape(text)) do |value|
        "<span class='glyphicon glyphicon-new-window'></span>#{('&nbsp;' + value) if show_link}"
      end
    end

    # *Sometimes* a Blacklight index field helper_method
    # @param [String,User,Hash{Symbol=>Array}] args if a hash, the user_key must be under :value
    # @return [ActiveSupport::SafeBuffer] the html_safe link
    def link_to_profile(args)
      user_or_key = args.is_a?(Hash) ? args[:value].first : args
      user = case user_or_key
             when User
               user_or_key
             when String
               ::User.find_by_user_key(user_or_key)
             end
      return user_or_key if user.nil?
      text = user.respond_to?(:name) ? user.name : user_or_key
      link_to text, Hyrax::Engine.routes.url_helpers.user_path(user)
    end

    # A Blacklight index field helper_method
    # @param [Hash] options from blacklight helper_method invocation. Maps license URIs to links with labels.
    # @return [ActiveSupport::SafeBuffer] license links, html_safe
    def license_links(options)
      service = Hyrax.config.license_service_class.new
      to_sentence(options[:value].map { |right| link_to service.label(right), right })
    end

    # A Blacklight index field helper_method
    # @param [Hash] options from blacklight helper_method invocation. Maps rights statement URIs to links with labels.
    # @return [ActiveSupport::SafeBuffer] rights statement links, html_safe
    def rights_statement_links(options)
      service = Hyrax.config.rights_statement_service_class.new
      to_sentence(options[:value].map { |right| link_to service.label(right), right })
    end

    # A Blacklight facet field helper_method
    # @param [String] value from blacklight helper_method invocation.
    # @return [String] the decoded meaning of the boolean field
    def suppressed_to_status(value)
      case value
      when 'false'
        t('hyrax.admin.workflows.index.tabs.published')
      else
        t('hyrax.admin.workflows.index.tabs.under_review')
      end
    end

    def link_to_telephone(user)
      return unless user
      link_to user.telephone, "wtai://wp/mc;#{user.telephone}" if user.telephone
    end

    # Only display the current search parameters if the user is not in the dashboard.
    # Otherwise, search defaults to the user's works and not all of Hyrax.
    def current_search_parameters
      return if on_the_dashboard?
      params[:q]
    end

    # @return [String] the appropriate action url for our search form (depending on our current page)
    def search_form_action
      if on_the_dashboard?
        search_action_for_dashboard
      else
        main_app.search_catalog_path
      end
    end

    def user_display_name_and_key(user_key)
      user = ::User.find_by_user_key(user_key)
      return user_key if user.nil?
      user.respond_to?(:name) ? "#{user.name} (#{user_key})" : user_key
    end

    # Used by the gallery view
    def collection_thumbnail(_document, _image_options = {}, _url_options = {})
      content_tag(:span, "", class: [Hyrax::ModelIcon.css_class_for(Collection), "collection-icon-search"])
    end

    def collection_title_by_id(id)
      solr_docs = controller.repository.find(id).docs
      return nil if solr_docs.empty?
      solr_field = solr_docs.first[Solrizer.solr_name("title", :stored_searchable)]
      return nil if solr_field.nil?
      solr_field.first
    end

    private

      def user_agent
        request.user_agent || ''
      end

      def count_classes_for(unread_count)
        'count label '.tap do |classes|
          classes << if unread_count.zero?
                       'invisible label-default'
                     else
                       'label-danger'
                     end
        end
      end

      def search_action_for_dashboard
        case params[:controller]
        when "hyrax/my/collections"
          hyrax.my_collections_path
        when "hyrax/my/shares"
          hyrax.dashboard_shares_path
        when "hyrax/my/highlights"
          hyrax.dashboard_highlights_path
        when "hyrax/dashboard/works"
          hyrax.dashboard_works_path
        when "hyrax/dashboard/collections"
          hyrax.dashboard_collections_path
        else
          # hyrax/my/works controller and default cases.
          hyrax.my_works_path
        end
      end
      # rubocop:enable Metrics/MethodLength

      # @param [ActionController::Parameters] params first argument for Blacklight::SearchState.new
      # @param [Hash] facet
      # @note Ignores all but the first facet.  Probably a bug.
      def search_state_with_facets(params, facet = {})
        state = Blacklight::SearchState.new(params, CatalogController.blacklight_config)
        return state.params if facet.none?
        state.add_facet_params(Solrizer.solr_name(facet.keys.first, :facetable),
                               facet.values.first)
      end

      def institution
        Institution
      end
  end
end
