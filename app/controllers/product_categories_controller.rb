class ProductCategoriesController < ApplicationController
  before_action :check_permission
  before_action :set_product_category, only: %i[ show edit update destroy ]

  # GET /product_categories or /product_categories.json
  def index
    @product_categories = ProductCategory.all
  end

  # GET /product_categories/1 or /product_categories/1.json
  def show
  end

  # GET /product_categories/new
  def new
    @product_category = ProductCategory.new
  end

  # GET /product_categories/1/edit
  def edit
  end

  # POST /product_categories or /product_categories.json
  def create
    @product_category = ProductCategory.new(product_category_params)

    if @product_category.save
      redirect_to product_categories_url, notice: "Product category was successfully created."
    else
      frender :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_categories/1 or /product_categories/1.json
  def update
    if @product_category.update(product_category_params)
      redirect_to product_categories_url, notice: "Product category was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /product_categories/1 or /product_categories/1.json
  def destroy
    @product_category.destroy
    redirect_to product_categories_url, notice: "Product category was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:category_name)
    end

    def check_permission
      unless current_user&.is_admin?
        redirect_to root_path, notice: "You don't have the permission"
      end
    end
end
