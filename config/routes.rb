Rails.application.routes.draw do

  #get 'image_display_names/new'
  resources :image_display_names, :only => [ :new, :create ]

  get 'folder_numbers/index'

  get 'folder_numbers/show'

  get 'folder_numbers/new'

  get 'folder_numbers/edit'

  #get 'doi_blocker_lists/index'

  get 'search_assist/index'

  resources :hyrax_checksums, :only => [ :index, :create, :update ]
  resources :doi_blocker_lists, :only => [ :index ]

  resources :folder_numbers do
    member do
      get :delete
    end
    collection do
      get :export
    end
  end

  mount Bulkrax::Engine, at: '/'
  resources :ingests

  get 'import/index'

  get 'search_tips' => 'hyrax/pages#show', key: 'search_tips'

  # TODO: remove get import/picker
  get 'import/picker'

  post 'import/picker'
  get 'export/dublinCore'
  get 'export_bulk/dublinCore'
  get 'doi/createDoi'

  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  mount Blacklight::Engine => '/'

    concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  #mount Sidekiq::Web => '/sidekiq'
  # config/routes.rb
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount BrowseEverything::Engine => '/browse'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
