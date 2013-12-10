module WordifyCms

  module Blog

    class Post
      include ::Mongoid::Document
      include ::Mongoid::Timestamps

      include WordifyCms::Blog::ClassDefinition
      include WordifyCms::Blog::Attributeable

      dasherize_attributes :title

      field :title,     :type => String
      field :text,      :type => String
      field :permalink, :type => String

      belongs_to :category,         :class_name => "WordifyCms::Blog::Category"
      belongs_to :author,           :class_name => "WordifyCms::Account"
      belongs_to :permalink_alias,  :class_name => "WordifyCms::PageAlias"

      validates_presence_of :text
      validates_presence_of :title

      def to_liquid
        liquidables = {
          "title"     => self.title,
          "text"      => self.text
        }
        if self.category.present?
          liquidables["category"] = self.category.attributes
        end
        if permalink_alias.present?
          liquidables["link"] = self.permalink_alias.url
        end
        liquidables
      end
    end

  end
end