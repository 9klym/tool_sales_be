# frozen_string_literal: true

module Api
  module V1
    class InvoiceController < Devise::SessionsController
      include Response
      before_action :authenticate_user!

      def index
        @invoices = if filter_params[:first_date] || filter_params[:last_date]
                      Invoice.where('created_at BETWEEN ? AND ?', first_date - 2.hours, last_date + 1.day - 2.hours)
                    else
                      Invoice.all
                    end
        data = @invoices&.map do |invoice|
          products = find_products(invoice.id)
          { id: invoice.id, date: invoice.created_at, products: products, supplier_name: @supplier_name }
        end
        json_response('Invoices', true, data, :ok)
      end

      def create
        create_params
        ActiveRecord::Base.transaction do
          invoice = Invoice.create!
          @hash['data'].each do |data|
            invoice.invoice_supplier_products
                   .build(supplier_product_id: data['supplier_product_id'],
                          count: data['count'],
                          price: SupplierProduct.find(data['supplier_product_id']).price).save
          end
          json_response('Invoices created', true, nil, :ok)
        end
      end

      private

      def create_params
        @hash ||= JSON.parse request.raw_post
      end

      def filter_params
        params.permit(:first_date, :last_date)
      end

      def find_products(invoice_id)
        @products =
          InvoiceSupplierProduct.joins(:supplier_product)
                                .joins('INNER JOIN suppliers ON suppliers.id = supplier_products.supplier_id')
                                .joins('INNER JOIN products ON products.id = supplier_products.product_id')
                                .where(invoice_id: invoice_id)
                                .pluck('invoice_supplier_products.id', 'products.name', \
                                       'invoice_supplier_products.count', 'invoice_supplier_products.price', \
                                       'suppliers.name')
        decorate_products
      end

      def decorate_products
        @products.map do |product|
          @supplier_name = product[4]
          { id: product[0], name: product[1], count: product[2], price: product[3] }
        end
      end

      def first_date
        filter_params[:first_date]&.to_date || DateTime.now-1.year
      end

      def last_date
        filter_params[:last_date]&.to_date || DateTime.now
      end

      attr_reader :suppliers
    end
  end
end
