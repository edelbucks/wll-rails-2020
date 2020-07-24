require 'uri'

class Api::ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  # GET /articles
  def index
    @articles = Article.where(published: true).select(:id, :path, :title, :description, :updated_at)

    render json: @articles
  end

  def homepage
    @articles = Article.where(on_homepage: true, published: true)
    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    unless path
      render json: {error: 'not found'}, status: :not_found
    end


    articles = Article.where(path: path).order('updated_at DESC')
    max = -1
    articles.each {|a| max = a.version if a.version && a.version > max}

    if articles.first
      articles.first.published = false
      articles.first.save!
    end

    @article = Article.new(article_params)
    if max > -1
      @article.version = max + 1
    end

    if @article.save!
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  # GET /articles/*path
  #
  def by_path
    articles = Article.where(path: path).order('updated_at DESC')
    unless articles&.first
      render json: {error: 'not found'}, status: :not_found
    end
    @article = articles.first
    render json: @article
  end

  private

  def path
    path = URI.decode_www_form_component(params[:path]).sub(/\.(json|md)$/, '')
    unless path && !path.blank?
      return '';
    end
    unless path.match(/\.md$/)
      path += '.md'
    end
    path
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :version, :directory, :sha, :meta, :description, :content, :published, :on_homepage, :file_creatred, :file_revised, :path)
  end
end
