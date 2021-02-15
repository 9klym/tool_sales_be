# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sign_in', to: 'session#create'
        delete 'log_out', to: 'session#delete'
      end
    end
  end
end
