namespace :wordify_blog do
  namespace :db do
    desc 'Seeds blog extension database structure'
    task :seed => :environment do
      category_model  = WordifyCms::DbModel.where(:name => "BlogCategory").first
      post_model      = WordifyCms::DbModel.where(:name => "BlogPost").first

      if category_model.nil?
        category_attrs = [
          {
            :field => "name", :type => "String"
          }
        ]

        category_model                      = WordifyCms::DbModel.new
        category_model.name                 = "BlogCategory"
        category_model.defined_attributes   = category_attrs
        category_model.identifier_attribute = "name"

        category_model.save
      end

      if post_model.nil?
        attrs = [
          {
            :field => "title", :type => "String"
          },
          {
            :field => "text", :type => "String"
          },
          {
            :field => "author_id", :type => "String"
          }
        ]

        references = [
          {
            :name       => "category",
            :class_name => "WordifyCms::DbModel",
            :id         => category_model.id
          }
        ]

        post_model                      = WordifyCms::DbModel.new
        post_model.name                 = "BlogPost"
        post_model.defined_attributes   = attrs
        post_model.identifier_attribute = "title"
        post_model.references           = references

        post_model.save
      end
    end
  end
end