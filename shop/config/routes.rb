class DomainConstraint
  def initialize(domain)
    @domains = [domain].flatten
  end

  def matches?(request)
    f = false
    @domains.map do |domain|
      f = true if [request.subdomain , request.domain].join('.').include? domain
    end
    f
  end
end


Myshop::Application.routes.draw do
	  get '/' => 'index#index',  :as =>  'myshop_index'
          get '/search' => 'index#search', :as => 'myshop_search'
	  get '/category/:category_id' => 'index#category', :as => 'myshop_category_translit'
	  get '/product/:id' => 'index#product', :as => 'myshop_product_translit'
          post '/order' => 'index#order', :as => 'myshop_order', :formats => [:js]
          get '/car' => 'index#car', :as => 'myshop_car'
end
