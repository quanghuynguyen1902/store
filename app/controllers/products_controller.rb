class ProductsController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to @product, notice: t('products.created')
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    
    # Handle image removal
    handle_image_removal
    
    if @product.update(product_params)
      redirect_to @product, notice: t('products.updated')
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: t('products.deleted')
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :specifications, :main_image, gallery_images: [])
  end
  
  def handle_image_removal
    # Remove main image if requested
    if params[:product][:remove_main_image] == '1'
      @product.main_image.purge
    end
    
    # Remove selected gallery images
    if params[:product][:remove_gallery_images].present?
      images_to_remove = params[:product][:remove_gallery_images].reject(&:blank?)
      images_to_remove.each do |image_id|
        image = @product.gallery_images.find(image_id)
        image.purge if image
      end
    end
  end
end
