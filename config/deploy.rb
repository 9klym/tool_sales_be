
# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.15.0'

set :default_env, {
  PATH: '$HOME/.npm-packages/bin/:$PATH',
  NODE_ENVIRONMENT: 'production',
}

set :application, 'tool_sales_be'
set :repo_url, 'git@github.com:9klym/tool_sales_be'

set :deploy_to, "//var/www/#{fetch(:application)}"
set :linked_files, %w{config/master.key}

set :migration_role, :db