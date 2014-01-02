module WordifyCms
  module Blog
    class Configuration
      include ::Mongoid::Document
      include ::Mongoid::Timestamps

      belongs_to :blog_main_page,         :class_name => "WordifyCms::Page"
      belongs_to :blog_post_detail_page,  :class_name => "WordifyCms::Page"
      belongs_to :category_page,          :class_name => "WordifyCms::Page"

      delegate :slug, :to => :blog_main_page, :prefix => :blog_prefix

      field :per_page_pagination, :type     => Integer,
                                  :default  => 10

    end
  end
end