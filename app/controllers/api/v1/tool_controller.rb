# frozen_string_literal: true

module Api
  module V1
    class ToolController < Devise::SessionsController
      include Response
      before_action :authenticate_user!

      def index
        json_response('Tools', true, { tools: decorate_tool }, :ok)
      end

      private

      def filter_params
        params.permit(:supplier_ids)
      end

      def decorate_tool
        tools.joins(:supplier, :product)
             .select('supplier_products.id, supplier_products.supplier_id, supplier_products.product_id,
                      supplier_products.price, suppliers.name as supplier_name, products.vendor_code,
                      products.name, products.image')
      end

      def tools
        return SupplierProduct.all unless filter_params[:supplier_ids]

        SupplierProduct.where(id: filter_params[:supplier_ids])
      end
    end
  end
end
