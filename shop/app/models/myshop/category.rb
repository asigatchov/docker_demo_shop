class Myshop::Category < ActiveRecord::Base
  require 'utils'
  self.table_name =  'my_shop_ru.ms_category'

  has_many :sub_categories,  :class_name => 'Myshop::Category', :foreign_key => :parentId
  has_many :products, :class_name  => 'Myshop::Product', :foreign_key =>  :categoryId
  belongs_to :parent  , :class_name => 'Myshop::Category' , :foreign_key => :parentId
#  has_many :sub_categories_products, :class_name  => 'Myshop::Product', 
#      :conditions =>"categoryId in (#{self.children_a})"

  def children_a
   children.split(',')
  end

  def sub_categories_products
    Myshop::Product.includes(:category).where(:categoryId => children_a)
  end
  def parent_all
    a = []
    c = nil
    if parent
        a << parent 
        c = parent
    end
    while c 
       c = c.parent
     a << c if c
    end  
    a.reverse
  end

  def tr_name 
    Utils.translit(name).to_s.gsub(/[^\w\-_]+/, '_').gsub(/_+/,'_')
  end
end
