module WordifyCms
  module Blog

    class Category
      include ::Mongoid::Document

      field :name, :type => String

      has_many :posts, :class_name => "WordifyCms::Blog::Post"

      validates_presence_of :name

      def to_liquid
        liquidable_posts = self.posts.desc(:created_at).map(&:to_liquid)
        {
          "name"        => self.name,
          "posts"       => liquidable_posts,
          "post_count"  => liquidable_posts.size
        }
      end
    end
  end
end