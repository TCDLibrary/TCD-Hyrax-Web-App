class SearchAssistController < ApplicationController

    layout :search_assist_layout


  def index
  end

  private

    def search_assist_layout
      action_name == 'index' ? 'homepage' : 'hyrax/dashboard'
    end
end
