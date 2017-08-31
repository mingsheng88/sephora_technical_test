module Api::V1
  class ProductsController < ApplicationController
    private

    def base_meta
      default_page_number = 1

      super.merge({
        page_number: params.dig(:page, :number) || default_page_number,
        page_size: params.dig(:page, :size) || Api::V1::ProductResource::DEFAULT_PAGE_SIZE,
      })
    end
  end
end
