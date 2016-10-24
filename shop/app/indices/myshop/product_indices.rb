ThinkingSphinx::Index.define 'myshop/product', :with => :active_record do
  indexes name,  :sortable => true
  indexes description, :sortable => true
end
