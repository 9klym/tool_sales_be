# frozen_string_literal: true

role :app, %w[35.173.187.92]
role :web, %w[35.173.187.92]
role :db,  %w[35.173.187.92]

server '35.173.187.92', user: 'ubuntu', roles: %w{web app}
set :rails_env, 'production'

set :rvm_type, :user
set :rvm_ruby_version, '2.7.1'
