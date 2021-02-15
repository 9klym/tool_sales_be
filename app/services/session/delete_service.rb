# frozen_string_literal: true

module Session
  class DeleteService
    attr_reader :success
    def initialize(user:)
      @success = false
      @user = user
    end

    def perform
      return unless user
      generete_new_token
    end

    def generete_new_token
      user.update_attribute(:authentication_token, User.generate_unique_secure_token)
      @success = true
    end

    private
    attr_reader :user
  end
end
