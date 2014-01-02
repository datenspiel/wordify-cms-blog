module WordifyCms
  module Blog

    class Category
      include ::Mongoid::Document
      include WordifyCms::Blog::ClassDefinition
      include WordifyCms::Blog::Attributeable

      dasherize_attributes :name

      field       :name,        :type => String

      has_many    :posts,       :class_name => "WordifyCms::Blog::Post"
      belongs_to  :link_alias,  :class_name => "WordifyCms::PageAlias"

      validates_presence_of :name

      def to_liquid
        liquidable_posts = self.posts.desc(:created_at).map(&:to_liquid)
        liquidables = {
          "name"        => self.name,
          "posts"       => liquidable_posts,
          "post_count"  => liquidable_posts.size
        }
        if link_alias.present?
          liquidables["link"] = link_alias.url
        end
        liquidables
      end
    end
  end
end