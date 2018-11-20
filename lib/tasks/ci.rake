# frozen_string_literal: true
unless Rails.env.production?
  require 'solr_wrapper/rake_task'

  desc "Run Continuous Integration"
  task :ci do |task, args|
    with_server 'test' do
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['ci'].invoke
    end
  end
end
