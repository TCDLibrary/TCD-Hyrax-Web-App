# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvmahX*ied8u
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#

# JL : 16/12/2019 Moving away from rvm??
#require "capistrano/rvm"

require "capistrano/rbenv"
set :rbenv_type, :user
set :rbenv_ruby, '2.6.9'

#require "capistrano/chruby"
require "capistrano/bundler"
#require "capistrano/rails/assets"
#require "capistrano/rails/migrations"
require "capistrano/rails"
require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

# JL 11/10/2019 added to allow capistrano use sudo
require 'sshkit/sudo'
