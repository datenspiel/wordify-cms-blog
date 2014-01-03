module WordifyCms
  module Blog
    class CategoryObserver < ::Mongoid::Observer
      observe WordifyCms::Blog::Category

      def before_save(record)
        self.class.send(:include,WordifyCms::Blog::Aliasable)

        category_plugin = Class.new do

          def call(config)
            blog_config           = config.fetch(:blog_config)
            record                = config.fetch(:record)
            page_alias            = config.fetch(:page_alias)
            permalink_prefix      = config.fetch(:permalink_prefix)
            category_page_prefix  = blog_config.category_page.slug.
                                                gsub(/^\/+|\/+$/, "")
            permalink             = [ permalink_prefix,
                                      category_page_prefix,
                                      record.dasherized_name ].join("/")
            page_alias.url        = permalink
            page_alias.page       = blog_config.category_page

            page_alias.save
            page_alias
          end

        end

        record.link_alias = blog_aliasing(record).call(category_plugin)
      end

    end
  end
end

Mongoid.observers << WordifyCms::Blog::CategoryObserver