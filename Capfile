# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/puma'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma

# Loads custom tasks from `lib/capistrano/tasks'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }