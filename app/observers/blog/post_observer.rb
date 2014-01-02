module WordifyCms
  module Blog
    class PostObserver < ::Mongoid::Observer
      observe WordifyCms::Blog::Post

      def before_save(record)
        self.class.send(:include,WordifyCms::Blog::Aliasable)

        post_plugin = Class.new do

          def call(config)
            blog_config       = config.fetch(:blog_config)
            record            = config.fetch(:record)
            permalink_prefix  = config.fetch(:permalink_prefix)
            page_alias        = config.fetch(:page_alias)
            permalink = if record.permalink.blank?
              "/#{record.dasherized_title}"
            else
              record.permalink
            end

            if permalink_prefix.present?
              regexp              = Regexp.new("^\\#{permalink_prefix}")

              unless permalink.match(regexp)
                permalink  = "#{permalink_prefix}#{permalink}"
              end
            end

            page_alias.url          = permalink
            page_alias.page         = blog_config.blog_post_detail_page
            page_alias.save
            page_alias
          end

        end

        page_alias              = blog_aliasing(record).call(post_plugin)
        record.permalink        = page_alias.url if record.permalink.blank?
        record.permalink_alias  = page_alias
      end

    end
  end
end

Mongoid.observers << WordifyCms::Blog::PostObserver
