module WordifyCms
  module Blog

    class Category
      include ::Mongoid::Document

      field :name, :type => String

      has_many :posts, :class_name => "WordifyCms::Blog::Post"

      validates_presence_of :name
    end
  end
end