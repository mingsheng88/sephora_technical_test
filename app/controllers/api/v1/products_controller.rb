module Api::V1
  class ProductsController < ApplicationController
    def index
      render json: Product.all
    end

    def show
      render json: Product.first
    end
  end
end
