module Api::V1
  class ProductsController < ApplicationController
    def index
      add_includes_to_params
      super
    end

    def show
      add_includes_to_params
      super
    end

    private

    def add_includes_to_params
      params[:include] = 'brand,categories' if params[:include].nil?
    end

    def base_meta
      default_page_number = 1

      super.merge({
        page_number: params.dig(:page, :number) || default_page_number,
        page_size: params.dig(:page, :size) || Api::V1::ProductResource::DEFAULT_PAGE_SIZE,
      })
    end
  end
end
