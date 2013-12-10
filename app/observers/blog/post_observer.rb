module WordifyCms
  module Blog
    class PostObserver < ::Mongoid::Observer
      observe WordifyCms::Blog::Post

      def before_save(record)
        permalink = if record.permalink.blank?
          "/#{record.dasherized_title}"
        else
          record.permalink
        end

        blog_config         = WordifyCms::Blog::Configuration.last
        if blog_config.present?
          permalink_prefix = blog_config.blog_prefix_slug
        else
          permalink_prefix = ""
        end

        page_alias          = WordifyCms::PageAlias.new
        page_alias.subject  = record

        if permalink_prefix.present?
          regexp              = Regexp.new("^\\#{permalink_prefix}")

          unless permalink.match(regexp)
            permalink  = "#{permalink_prefix}#{permalink}"
          end
        end

        page_alias.url          = permalink
        page_alias.page         = blog_config.blog_post_detail_page
        page_alias.save
        record.permalink        = permalink if record.permalink.blank?
        record.permalink_alias  = page_alias
      end

    end
  end
end

Mongoid.observers << WordifyCms::Blog::PostObserver
