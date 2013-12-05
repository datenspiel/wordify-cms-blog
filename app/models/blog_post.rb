module WordifyCms

  module Blog

    class Post
      include ::Mongoid::Document
      include ::Mongoid::Timestamps

      field :title, :type => String

      field :text,  :type => String

      belongs_to :category, :class_name => "WordifyCms::Blog::Category"
      belongs_to :author,   :class_name => "WordifyCms::Account"

      validates_presence_of :text
      validates_presence_of :title
    end

  end
end