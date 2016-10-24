#encoding: utf-8
class IndexController < ApplicationController
  layout  'myshop'
  before_filter :load_categories
  before_filter :clear_search_s
  def index
    @seo_title = 'Интернет магазин'
    @seo_desc =  @categories.map(&:name).join(', ')
    render 'myshop/index'
  end

  def category
    @category =  Myshop::Category.find( params[:category_id] )
    @parent_all = @category.parent_all
    @seo_title = @parent_all.map(&:name).push(@category.name, 'Купить  с доставкой').join(', ')
    @seo_desc  = ''
    @products = @category.sub_categories_products.paginate(:page => params[:page]||1, :per_page => 20 )
    @seo_desc = @products.map(&:name).join(".\n")
    render 'myshop/category'
  end

  def product
    @product = Myshop::Product.find params[:id]
	@parent_all = @product.parent_all
	@seo_desc = @product.description.truncate(255, sepatator:' ')
	title = [ @product.name, @product.category.name, 'цена', @product.price.to_i, "рублей"]
	title << '. Скачать бесплатно?' if @product.book. == 'Y'
    @seo_title = title.join(' ')
    render 'myshop/product'
  end

  def search
    @seo_title =   @h1_title = "Вы искали: #{@search_query}"
    @products = Myshop::Product.search(  @search_query).page(params[:page] || 1)
    render 'myshop/category'
  end

  def order
    if  params[:pid]
       car = Hash[* cookies[:car].to_s.split(',').map{|i| i.split(':').map(&:to_i)}.flatten]
       car[params[:pid].to_i] =  car[params[:pid].to_i].to_i + 1
       cookies[:car] = { :value =>car.to_a.map{|i| i.join(':') }.join(',') , :expires => 1.year.from_now }
    end
    render 'myshop/order'
  end

  def car
    car = Hash[* cookies[:car].to_s.split(',').map{|i| i.split(':').map(&:to_i)}.flatten]
    render :text => car.to_s
  end

  private
  def load_categories
    @categories =  Myshop::Category.select([:id,:name]).includes(:sub_categories).where(:parentId => 0)
  end

  def clear_search_s
    @search_query = params[:s].to_s.gsub(%r{[^\w\d\p{Cyrillic}/]}, ' ').gsub(/\s+/, ' ')
    @search_query = Riddle::Query.escape(@search_query )
  end
end
