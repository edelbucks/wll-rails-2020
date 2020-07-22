class Api::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.all

    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  # GET /articles/*directory

  def by_path
    directory = URI.decode_www_form_component(params[:path]).sub(/\.(json|md)$/, '')
    p 'directory:', directory, 'from ', params[:path]
    @category = Category.find_by_directory(directory)
    @category_hash = @category.attributes
    @category_hash['articles'] = Article.select(:title, :published, :updated_at, :directory, :path, :description).where(directory: directory, published: true)
        .map{| a | a.attributes}
    p 'returning', @category_hash
    render json: @category_hash
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:directory, :title, :published, :content, :sequence)
    end
end
