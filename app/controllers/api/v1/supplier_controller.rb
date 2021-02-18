# frozen_string_literal: true

module Api
  module V1
    class SupplierController < Devise::SessionsController
      include Response
      before_action :authenticate_user!

      def index
        @suppliers = Supplier.all
        json_response('Suppliers', true, { suppliers: suppliers }, :ok)
      end

      attr_reader :suppliers
    end
  end
end
