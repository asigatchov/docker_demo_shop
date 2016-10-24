class Myshop::Product < ActiveRecord::Base
  self.table_name =  'my_shop_ru.ms_product'
  belongs_to :category, :class_name => 'Myshop::Category', :foreign_key => "categoryId" 

  def tr_name 
    Utils.translit(name).to_s.gsub(/[^\w\-_]+/, '_').gsub(/_+/,'_')
  end

  def parent_all
    a = []
    a << category
	c = category
	while c 
     c = c.parent
	 a << c if c
	end	
	a.reverse
  end


  def recommendation ids
   category.products.where(availabilityCode:[2,3]).where('id not in (?)', ids).order('rating desc')
 end

  
  def availabilityCode?
     attributes_before_type_cast['availabilityCode']> 1
  end
end
